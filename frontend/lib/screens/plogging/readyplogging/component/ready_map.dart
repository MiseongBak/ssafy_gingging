import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ReadyMap extends StatefulWidget {
  const ReadyMap({super.key});

  @override
  State<ReadyMap> createState() => _ReadyMapState();
}

class _ReadyMapState extends State<ReadyMap> {
  late double latitude;
  late double longitude;
  bool _isLocationLoaded = false; // 위치 데이터 로드 상태를 추적하는 플래그
  NaverMapController? _mapController; // 지도 컨트롤러를 옵셔널로 선언
  bool isSelectedTrashTong = false;
  bool isSelectedMonster = false;
  double _currentZoom = 15.0; // 클러스터링 초기 줌 레벨 설정
  bool _isCameraMoving = false;
  late UserProvider userProvider;
  late PloggingModel ploggingModel;
  late String accessToken;
  late Map<String, dynamic> trashLists;

  void _onCameraMoveStarted() {
    _isCameraMoving = true;
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _isLocationLoaded = true;
    });
    print('위치요 ${position.latitude}, ${position.longitude}');
    await ploggingModel.trashList(
        accessToken, position.latitude, position.longitude, 50);
    trashLists = ploggingModel.getTrashLists();
  }

  Future<List<dynamic>> readJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/trash_tong_data.json');
    return jsonDecode(jsonString);
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    ploggingModel = Provider.of<PloggingModel>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    getLocation();
  }

  @override
  void dispose() {
    _mapController!.dispose();
    super.dispose();
  }

  void trashTongToggle() {
    setState(() {
      isSelectedTrashTong = !isSelectedTrashTong;
    });
    // print(isSelectedTrashTong);
    updateMarkers();
  }

  void monsterToggle() {
    setState(() {
      isSelectedMonster = !isSelectedMonster;
    });
  }

  void _onCameraIdle() {
    if (_mapController == null) return;

    _mapController!.getCameraPosition().then((position) {
      // 유의미한 변화 확인
      if ((position.target.latitude - latitude).abs() > 0.0001 ||
          (position.target.longitude - longitude).abs() > 0.0001 ||
          (position.zoom - _currentZoom).abs() > 0.5) {
        setState(() {
          latitude = position.target.latitude;
          longitude = position.target.longitude;
          _currentZoom = position.zoom;
        });
        updateMarkers(); // 마커 업데이트
      }
    });
    print('위도: $latitude 경도: $longitude 줌: $_currentZoom');
    var plogging = Provider.of<PloggingModel>(context, listen: false);

    late int currentZoom = _currentZoom.round();
    late int radius;

    switch (currentZoom) {
      case 6:
        radius = 320000;
        break;
      case 7:
        radius = 160000;
        break;
      case 8:
        radius = 80000;
        break;
      case 9:
        radius = 40000;
        break;
      case 10:
        radius = 20000;
        break;
      case 11:
        radius = 10000;
        break;
      case 12:
        radius = 5000;
        break;
      case 13:
        radius = 2500;
        break;
      case 14:
        radius = 1250;
        break;
      case 15:
        radius = 600;
        break;
      case 16:
        radius = 150;
        break;
    }
    print('현재줌: $currentZoom, 값: $radius');
    plogging.trashList(accessToken, latitude, longitude, radius);
    trashLists = plogging.getTrashLists();
  }

  String _getClusterKey(Map<String, dynamic> data) {
    // 클러스터 키 생성 로직, 예: 위치를 기반으로 그리드 생성
    int gridLat = (double.parse(data['위도']) * 10).floor();
    int gridLng = (double.parse(data['경도']) * 10).floor();
    return "$gridLat:$gridLng";
  }

  void updateMarkers() async {
    if (_mapController == null || !_isLocationLoaded) return;
    await _mapController!.clearOverlays();

    var jsonData = await readJsonData();
    Map<String, List<NMarker>> clusters = {};

    if (isSelectedTrashTong) {
      for (var data in jsonData) {
        var key = _getClusterKey(data);

        if (!clusters.containsKey(key)) {
          clusters[key] = [];
        }
        clusters[key]!.add(
          NMarker(
            id: '${data['연번']}_${data['세부위치']}',
            position: NLatLng(
              double.parse(data['위도']),
              double.parse(data['경도']),
            ),
            icon: const NOverlayImage.fromAssetImage(AppIcons.trash_tong),
            size: const NSize(30, 40),
          ),
        );
      }
    }
    // print("줌 $_currentZoom");
    if (_currentZoom < 13) {
      await _mapController!.clearOverlays();
    }
    // 클러스터 또는 개별 마커 표시
    clusters.forEach(
      (key, markers) {
        if (_currentZoom < 13 && markers.length > 1) {
          // 클러스터 표시
          _displayClusterMarker(markers);
        } else {
          // 개별 마커 표시
          markers.forEach(
            (marker) async {
              await _mapController!.addOverlay(marker);

              final onMarkerInfoWindow = NInfoWindow.onMarker(
                id: marker.info.id,
                text: marker.info.id.split('_')[1],
              );

              marker.setOnTapListener(
                (NMarker marker) async => {
                  if (await marker.hasOpenInfoWindow())
                    {onMarkerInfoWindow.close()}
                  else
                    {marker.openInfoWindow(onMarkerInfoWindow)}
                },
              );
            },
          );
        }
      },
    );
  }

  void _displayClusterMarker(List<NMarker> markers) {
    // 클러스터 대표 마커 표시
    var centerLat = 0.0;
    var centerLng = 0.0;
    for (var marker in markers) {
      centerLat += marker.position.latitude;
      centerLng += marker.position.longitude;
    }
    centerLat /= markers.length;
    centerLng /= markers.length;

    NMarker clusterMarker = NMarker(
      id: "cluster_${markers[0].info.id}",
      position: NLatLng(centerLat, centerLng),
      icon: const NOverlayImage.fromAssetImage(AppIcons.trash_tong),
      // 클러스터 아이콘 설정
      size: const NSize(100, 100),
      caption: NOverlayCaption(text: '${markers.length}', textSize: 20),
    );
    _mapController!.addOverlay(clusterMarker);
  }

  bool _isTrashTongPressed = false;
  bool _isMonsterPressed = false;

  void _onTrashTongTapDown(TapDownDetails details) {
    setState(() {
      _isTrashTongPressed = true;
    });
  }

  void _onTrashTongTapUp(TapUpDetails details) {
    setState(() {
      _isTrashTongPressed = false;
    });
  }

  void _onTrashTongTapCancel() {
    setState(() {
      _isTrashTongPressed = false;
    });
  }

  void _onMonsterTapDown(TapDownDetails details) {
    setState(() {
      _isMonsterPressed = true;
    });
  }

  void _onMonsterTapUp(TapUpDetails details) {
    setState(() {
      _isMonsterPressed = false;
    });
  }

  void _onMonsterTapCancel() {
    setState(() {
      _isMonsterPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var trashLists = {};
    // if (_isLocationLoaded) {
    //   trashLists = Provider.of<PloggingModel>(context, listen: true).getTrashLists();
    // }

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white),
        boxShadow: [
          BoxShadow(
              color: AppColors.basicgray.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 1,
              spreadRadius: 1)
        ],
      ),
      child: _isLocationLoaded
          ? Stack(
              children: [
                NaverMap(
                  onMapReady: (controller) {
                    _mapController = controller; // 지도 컨트롤러 초기화
                    _mapController!
                        .setLocationTrackingMode(NLocationTrackingMode.follow);
                    updateMarkers(); // 지도 준비 완료 후 마커 업데이트 호출
                  },
                  onCameraIdle: _onCameraIdle,
                  options: NaverMapViewOptions(
                    // liteModeEnable: true,
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(latitude, longitude),
                      zoom: 15,
                      bearing: 0,
                      tilt: 0,
                    ),
                    locationButtonEnable: true,
                    maxZoom: 16,
                    minZoom: 6,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: GestureDetector(
                    onTap: () {
                      trashTongToggle();
                    },
                    onTapDown: _onTrashTongTapDown,
                    onTapUp: _onTrashTongTapUp,
                    onTapCancel: _onTrashTongTapCancel,
                    child: Container(
                      width: isSelectedTrashTong
                          ? MediaQuery.of(context).size.width * 0.18
                          : MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: _isTrashTongPressed
                            ? []
                            : [
                                BoxShadow(
                                  color: AppColors.basicgray.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.004,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                              height: MediaQuery.of(context).size.height * 0.04,
                              // color: Colors.black,
                              child: Image.asset(AppIcons.trash_tong),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.width * 0.02,
                            child: Text(
                              isSelectedTrashTong ? '취소' : '쓰레기통 위치 확인',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung60,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: GestureDetector(
                    onTap: () {
                      monsterToggle();
                    },
                    onTapDown: _onMonsterTapDown,
                    onTapUp: _onMonsterTapUp,
                    onTapCancel: _onMonsterTapCancel,
                    child: Container(
                      width: isSelectedMonster
                          ? MediaQuery.of(context).size.width * 0.18
                          : MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: _isMonsterPressed
                            ? []
                            : [
                                BoxShadow(
                                  color: AppColors.basicgray.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.007,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                              height: MediaQuery.of(context).size.height * 0.04,
                              // color: Colors.black,
                              child: Image.asset(AppIcons.mizzomon),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.width * 0.02,
                            child: Text(
                              isSelectedMonster ? '취소' : '몬스터 출몰 현황',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                isSelectedMonster
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.2,
                        left: MediaQuery.of(context).size.height * 0.007,
                        child: IgnorePointer(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(300),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '플라몽',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                              Text(
                                                '${trashLists['plastic']}마리',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                              Text(
                                                '처치',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            AppIcons.plamong,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.24,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppIcons.pocanmong,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '포 캔몽',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                              Text(
                                                '${trashLists['can']}마리',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                              Text(
                                                '처치',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '율몽',
                                            style: CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung70),
                                          ),
                                          Text(
                                            '${trashLists['glass']}마리',
                                            style: CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung70),
                                          ),
                                          Text(
                                            '처치',
                                            style: CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung70),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppIcons.yulmong,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppIcons.mizzomon,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.24,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '미쪼몬',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                              Text(
                                                '${trashLists['normal']}마리',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                              Text(
                                                '처치',
                                                style: CustomFontStyle
                                                    .getTextStyle(
                                                        context,
                                                        CustomFontStyle
                                                            .yeonSung70),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
