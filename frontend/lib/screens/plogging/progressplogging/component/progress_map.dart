import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/plogging_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/plogging/finishplogging/finish_plogging_dialog.dart';
import 'package:frontend/screens/plogging/progressplogging/component/finishcheck_plogging.dart';
import 'package:frontend/screens/plogging/progressplogging/component/total_trash.dart';
import 'package:frontend/screens/plogging/progressplogging/dialog/box_dialog.dart';
import 'package:frontend/screens/plogging/progressplogging/dialog/retry_connected_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_trash_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_kill_trash_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_lacation_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gif_view/gif_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;

class ProgressMap extends StatefulWidget {
  const ProgressMap({
    super.key,
  });

  @override
  State<ProgressMap> createState() => _ProgressMapState();
}

class _ProgressMapState extends State<ProgressMap> {
  late MainProvider mainProvider;
  late UserProvider userProvider;
  late PloggingProvider ploggingProvider;
  late PetModel petModel;
  late Map<String, dynamic> currentPet;

  late BluetoothDevice device;
  late double latitude;
  late double longitude; // 현재 위치 위도 경도를 업데이트 해 줄 변수
  double previousLatitude = 0;
  double previousLongitude = 0; // 직전 위도 경도 변수
  final List<NLatLng> _pathPoints = []; // 실시간 경로를 저장할 변수
  late StreamSubscription<Position> pathStream; // 실시간 경로 받아오는 stream 객체 변수
  late double totalDistance;
  bool isTrashTotal = false; // 쓰레기 현황 보여줄지 현재 주운 쓰레기 보여 줄지 체크
  bool _isLocationLoaded = false; // 위치 데이터 로드 상태를 추적하는 플래그
  NaverMapController? _mapController; // 지도 컨트롤러를 옵셔널로 선언
  bool isSelectedTrashTong = false;
  final double _currentZoom = 15.0; // 클러스터링 초기 줌 레벨 설정
  List<NMarker> trashTongs = []; // 쓰레기통 마커 변수
  List<Map<String, double>> path = []; // 종료 시 보내 줄 경로 정보
  bool isStart = true;

  // 블루투스용 변수들
  late double trashLatitude, trashLongitude; // 현재 위치 위도 경도를 업데이트 해 줄 변수
  late BluetoothCharacteristic _notifyChar;
  late StreamSubscription<List<int>> blueSubscription;
  int trashId = 0;
  List<int> imageResult = []; // 블루투스로 데이터 받을 때 저장 변수
  List<int> imageBytes = []; // 이미지 넘기는 변수
  String base64String = '';

  // api 응답 관련 변수
  late PloggingModel ploggingModel;
  late StreamSubscription<BluetoothConnectionState> isConnected;
  late int ploggingId;
  late String accessToken, displayMonster, monsterIcon;
  late bool isExp;
  bool isKill = false;
  bool isKilling = false;
  int plastic = 0, can = 0, glass = 0, normal = 0, box = 0, value = 0;

  late bool memberTutorial;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    memberTutorial = userProvider.getMemberTutorial();
    ploggingModel = Provider.of<PloggingModel>(context, listen: false);
    ploggingProvider = Provider.of<PloggingProvider>(context, listen: false);
    petModel = Provider.of<PetModel>(context, listen: false);
    currentPet = petModel.getCurrentPet();
    isExp = !currentPet['active'];
    ploggingProvider.setTrashs(0, 0, 0, 0, 0, 0, isExp);
    accessToken = userProvider.getAccessToken();
    startAPI();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    device = mainProvider.getDevice();
    findServiceAndCharacteristics();
    totalDistance = 0;
    retryConnect();
    getPathLocation();
    realTimePath();
  }

  // 위젯 제거 될 때 controller 제거, Stream 구독 취소
  @override
  void dispose() {
    pathStream.cancel();
    device.disconnect();
    isConnected.cancel();
    _mapController!.dispose();
    super.dispose();
  }

  void startAPI() async {
    await ploggingModel.ploggingStart(accessToken, -1);
    ploggingId = ploggingModel.getPloggingId();
  }

  void retryConnect() {
    isConnected =
        device.connectionState.listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.disconnected) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return RetryConnectedDialog(
              onFinish: showFinishPloggingDialog,
              onConnect: () {
                device = mainProvider.getDevice();
                findServiceAndCharacteristics();
              },
            );
          },
        );
      }
    });
  }

  // 기기 서비스와 해당 서비스의 필요한 characteristic 연결 함수
  void findServiceAndCharacteristics() async {
    List<BluetoothService> services = await device.discoverServices();

    for (BluetoothService service in services) {
      if (service.uuid == Guid('6E400001-B5A3-F393-E0A9-E50E24DCCA9E')) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid ==
              Guid('6E400003-B5A3-F393-E0A9-E50E24DCCA9E')) {
            _notifyChar = characteristic;
            await _notifyChar.setNotifyValue(true);
            blueSubscription = _notifyChar.onValueReceived.listen((event) {
              // print('Received: ${String.fromCharCodes(event)} 길이 : ${event.length}');

              // 블루투스 연결 시 0 으로 데이터가 계속 넘어옴 0일 경우 return
              // 0이면서 쓰레기 데이터가 비어있지 않다면 데이터 합쳐서 쓰레기 줍기 api 요청
              if (String.fromCharCodes(event) == '0') {
                if (imageResult.isNotEmpty) {
                  imageBytes.addAll(imageResult);
                  // base64String = base64Encode(imageResult);
                  // print('총길이 ${base64String.length}');
                  // setState(() {});
                  imageResult.clear();
                  // 쓰레기 판별 함수 실행 API 콜
                  getClassficationData();
                }
                return;
              }
              // 데이터 수신 시작했으므로 위치 저장
              if (imageResult.isEmpty) {
                isKilling = true;
                setState(() {});
                getTrashLocation();
              }
              // '|' 뒤 데이터 저장
              List<int> result = [];
              for (int i = 0; i < event.length; i++) {
                if (String.fromCharCode(event[i]) == '|') {
                  result = event.sublist(i + 1);
                  break;
                }
              }
              imageResult.addAll(result);
              print('결과물 길이 ${result.length}');
            });
            device.cancelWhenDisconnected(blueSubscription);
          }
        }
      }
    }
  }

  getClassficationData() {
    ploggingModel
        .classificationTrash(
            accessToken, trashLatitude, trashLongitude, imageBytes)
        .then((data) {
      if (data == 'Success') {
        Map<String, dynamic> classificationData =
            ploggingModel.getClassificationData();
        if (classificationData.isNotEmpty) {
          switch (classificationData['trash_type']) {
            case 'NORMAL':
              normal += 1;
              displayMonster = '미쪼몽';
              monsterIcon = AppIcons.mizzomon;
              drawData(classificationData);
              break;
            case 'CAN':
              can += 1;
              displayMonster = '포캔몽';
              monsterIcon = AppIcons.pocanmong;
              drawData(classificationData);
              break;
            case 'PLASTIC':
              plastic += 1;
              displayMonster = '플라몽';
              monsterIcon = AppIcons.plamong;
              drawData(classificationData);
              break;
            case 'GLASS':
              glass += 1;
              displayMonster = '율몽';
              monsterIcon = AppIcons.yulmong;
              drawData(classificationData);
              break;
            default:
              return; // 판별하지 못했다면 마커 찍지 X
          }
        }
        if (memberTutorial == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PloggingTutorialKillTrashDialog(
                  displayMonster: displayMonster,
                  monsterIcon: monsterIcon,
                  onConfirm: showFinishPloggingDialog,
                );
              },
            );
          });
        }
        return ploggingModel.getClassificationData();
      } else {
        isKilling = false;
        setState(() {});
        return;
      }
    });
    imageBytes.clear();
  }

  void drawData(Map<String, dynamic> classificationData) {
    setState(() {
      value += classificationData['value'] as int;
      if (classificationData['rescue']) {
        box += 1;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const BoxDialog();
          },
        );
      }

      isKill = true;
      isKilling = false;
      Future.delayed(const Duration(seconds: 3), () {
        isKill = false;
        setState(() {});
      });
      ploggingProvider.setTrashs(
          plastic, can, glass, normal, value, box, isExp);
      trashId += 1;
      NMarker trashMarker = NMarker(
        id: 'trash$trashId',
        position: NLatLng(trashLatitude, trashLongitude),
        icon: NOverlayImage.fromAssetImage(monsterIcon),
        size: const NSize(30, 40),
      );
      trashMarker.setGlobalZIndex(trashId);
      _mapController!.addOverlay(trashMarker);
    });
  }

  getTrashLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      trashLatitude = position.latitude;
      trashLongitude = position.longitude;
    });
  }

  // 현재 위치 조회하는 함수
  getPathLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _pathPoints.add(NLatLng(position.latitude, position.longitude));
      _isLocationLoaded = true;
      if (memberTutorial == false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PloggingTutorialLocationDialog();
            },
          ).then(
            (value) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const PloggingTutorialGetTrashDialog();
                },
              );
            },
          );
        });
      }
    });
    print('현재 위치 : ${position.latitude}, ${position.longitude}');
  }

// 실시간으로 경로 받아오는 함수
  realTimePath() {
    // distanceFilter의 거리 이동 시 계속해서 위치를 받아옴
    pathStream = Geolocator.getPositionStream(
            locationSettings: LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation,
                distanceFilter: 10))
        .listen((Position position) {
      if (isStart) {
        path.add(
            {'latitude': position.latitude, 'longitude': position.longitude});
        isStart = false;
      }
      if (position.speed < 1) {
        return;
      }
      setState(() {
        previousLatitude = _pathPoints.last.latitude;
        previousLongitude = _pathPoints.last.longitude;
        latitude = position.latitude;
        longitude = position.longitude;

        path.add(
            {'latitude': position.latitude, 'longitude': position.longitude});
        _pathPoints.add(NLatLng(latitude, longitude)); // 받아온 위치 추가하는 부분

        double distanceInMeters = Geolocator.distanceBetween(
            previousLatitude, previousLongitude, latitude, longitude);
        totalDistance += distanceInMeters; // 총거리에 더해주기
        print(
            '경로 : $previousLatitude, $previousLongitude -> $latitude, $longitude, 거리 : $distanceInMeters 총 거리 : $totalDistance');
      });
      _mapController!.addOverlay(NPathOverlay(
        id: 'realtime',
        width: 5,
        coords: _pathPoints,
        color: AppColors.basicgreen,
      ));
    });
  }

  // 지도에서 다른 화면을 보다가 현재 위치로 돌아오는 함수
  void returnCurrentLocation() async {
    await getPathLocation();
    print('현재 위치로 $latitude랑 $longitude');
    await _mapController!.updateCamera(NCameraUpdate.withParams(
        target: NLatLng(latitude, longitude), zoom: 15, bearing: 0, tilt: 45));
    _mapController!.setLocationTrackingMode(NLocationTrackingMode.face);
  }

  Future<List<dynamic>> readJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/trash_tong_data.json');
    return jsonDecode(jsonString);
  }

  void trashTongToggle() {
    setState(() {
      isSelectedTrashTong = !isSelectedTrashTong;
    });
    updateMarkers();
  }

  void createTrashtongMarkers() async {
    if (_mapController == null || !_isLocationLoaded) return;

    var jsonData = await readJsonData();

    for (var data in jsonData) {
      trashTongs.add(
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
    // 개별 마커 표시
    for (NMarker trashTong in trashTongs) {
      trashTong.setMinZoom(12);
      trashTong.setIsVisible(isSelectedTrashTong);
      _mapController!.addOverlay(trashTong);
      final onMarkerInfoWindow = NInfoWindow.onMarker(
        id: trashTong.info.id,
        text: trashTong.info.id.split('_')[1],
      );

      trashTong.setOnTapListener(
        (NMarker trashTong) async => {
          if (await trashTong.hasOpenInfoWindow())
            {onMarkerInfoWindow.close()}
          else
            {trashTong.openInfoWindow(onMarkerInfoWindow)}
        },
      );
    }
  }

  Future<NOverlayImage> createNOverlayImageFromNetwork(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List imageData = response.bodyBytes;
        return NOverlayImage.fromByteArray(imageData);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Error loading image: $e');
    }
  }

  void updateMarkers() {
    // 쓰레기통 마커 업데이트
    if (_currentZoom < 13 && trashTongs.length > 1) {
    } else {
      // 개별 마커 표시
      for (final trashTong in trashTongs) {
        trashTong.setIsVisible(isSelectedTrashTong);
      }
    }
  }

  void showFinishPloggingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return FinishPloggingDialog(
          totalDistance: totalDistance.floor(),
          path: path,
        );
      },
    ).then((_) {
      var petModel = Provider.of<PetModel>(context, listen: false);
      petModel.getPetDetail(accessToken, -1);
      var currency =
          Provider.of<UserProvider>(context, listen: false).getCurrency();
      if (!isExp) {
        userProvider.setCurrency(currency + value);
      }
      context.pushReplacement('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _isLocationLoaded
          ? Stack(
              children: [
                NaverMap(
                  onMapReady: (controller) async {
                    _mapController = controller; // 지도 컨트롤러 초기화

                    // 내 위치 표시 아이콘 설정
                    final mylocation = _mapController!.getLocationOverlay();
                    final myImage = await createNOverlayImageFromNetwork(
                        currentPet['image']);
                    mylocation.setIcon(
                      currentPet['active']
                          ? myImage
                          : const NOverlayImage.fromAssetImage(
                              AppIcons.intro_box),
                    );
                    mylocation.setIconSize(const NSize(50, 50));
                    mylocation.setCircleColor(Colors.transparent);

                    _mapController!
                        .setLocationTrackingMode(NLocationTrackingMode.face);

                    createTrashtongMarkers();
                  },
                  options: NaverMapViewOptions(
                      // minZoom: 13,
                      // maxZoom: 16,
                      scaleBarEnable: false,
                      logoAlign: NLogoAlign.leftTop,
                      logoMargin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      initialCameraPosition: NCameraPosition(
                          target: NLatLng(latitude, longitude),
                          zoom: 15,
                          bearing: 0,
                          tilt: 45)),
                ),

                // 이미지 확인용 코드
                // Positioned(
                //     child: base64String.isEmpty
                //         ? Image.asset(
                //             AppIcons.trash_tong,
                //             height: MediaQuery.of(context).size.height * 0.05,
                //             width: MediaQuery.of(context).size.height * 0.05,
                //           )
                //         : Image.memory(base64.decode(base64String))),
                Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                  child: GestureDetector(
                    onVerticalDragUpdate: (e) {
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) {
                            return const TotalTrash();
                          }));
                    },
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) {
                            return const TotalTrash();
                          }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.basicgray.withOpacity(0.2),
                                blurRadius: 1,
                                spreadRadius: 1)
                          ]),
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: const Center(
                        child: Text('원정 집계 현황'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.75,
                  right: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                trashTongToggle();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.basicgray
                                                .withOpacity(0.2),
                                            blurRadius: 1,
                                            spreadRadius: 1)
                                      ]),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: Center(
                                      child: Image.asset(
                                    AppIcons.trash_tong,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: MediaQuery.of(context).size.height *
                                        0.05,
                                  ))),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                returnCurrentLocation();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.basicgray
                                              .withOpacity(0.2),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: const Center(
                                  child: Icon(Icons.my_location),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FinishCheckPloggingDialog(
                                      onConfirm: showFinishPloggingDialog,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.basicgray
                                              .withOpacity(0.2),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Center(
                                  child: Text(
                                    '종 료',
                                    style: CustomFontStyle.getTextStyle(context,
                                        CustomFontStyle.yeonSung70_white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isKill
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.02,
                        right: MediaQuery.of(context).size.height * 0.02,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3, color: Colors.white),
                            boxShadow: [
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  // color: Colors.black,
                                  child: Image.asset(monsterIcon),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.width * 0.02,
                                child: Text(
                                  '$displayMonster 처치 + 1',
                                  style: CustomFontStyle.getTextStyle(
                                    context,
                                    CustomFontStyle.yeonSung60,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                isKilling
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IgnorePointer(
                              child: Container(
                                child: GifView.asset(
                                  AppIcons.effect,
                                  frameRate: 13,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '몬스터 처치중',
                                  style: CustomFontStyle.getTextStyle(
                                      context, CustomFontStyle.yeonSung150),
                                ),
                                Text(
                                  '.',
                                  style: CustomFontStyle.getTextStyle(
                                      context, CustomFontStyle.yeonSung150),
                                ),
                                Text(
                                  '.',
                                  style: CustomFontStyle.getTextStyle(
                                      context, CustomFontStyle.yeonSung150),
                                ),
                                Text(
                                  '.',
                                  style: CustomFontStyle.getTextStyle(
                                      context, CustomFontStyle.yeonSung150),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
