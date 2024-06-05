import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/history_model.dart';
import 'package:provider/provider.dart';

class HistoryDetailDialog extends StatefulWidget {
  final String date;
  final String time;

  const HistoryDetailDialog({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  State<HistoryDetailDialog> createState() => _HistoryDetailDialogState();
}

class _HistoryDetailDialogState extends State<HistoryDetailDialog> {
  late HistoryModel historyModel;
  late Map<String, dynamic> historyDetail;
  late double latitude;
  late double longitude;
  late List<dynamic> trashPath;
  late List<dynamic> walkPath;
  NaverMapController? _mapController;

  @override
  void initState() {
    super.initState();

    historyModel = Provider.of<HistoryModel>(context, listen: false);
    historyDetail = historyModel.getDetailHistory();
    trashPath = historyDetail['trash_list'];
    walkPath = historyDetail['route_list'];
  }

  drawPath() {
    if (walkPath.length > 1) {
      _mapController!.addOverlay(NPathOverlay(
        id: 'realtime',
        width: 5,
        coords: walkPath
            .map((e) => NLatLng(e['latitude'], e['longitude']))
            .toList(),
        color: AppColors.basicgreen,
      ));
    }
    for (int i = 0; i < trashPath.length; i++) {
      String monsterIcon = '';
      switch (trashPath[i]['type']) {
        case 'NORMAL':
          monsterIcon = AppIcons.mizzomon;
          break;
        case 'CAN':
          monsterIcon = AppIcons.pocanmong;
          break;
        case 'PLASTIC':
          monsterIcon = AppIcons.plamong;
          break;
        case 'GLASS':
          monsterIcon = AppIcons.yulmong;
          break;
        default:
          return; // 판별하지 못했다면 마커 찍지 X
      }

      NMarker trashMarker = NMarker(
        angle: 30,
        id: 'trash$i',
        position: NLatLng(trashPath[i]['latitude'], trashPath[i]['longitude']),
        icon: NOverlayImage.fromAssetImage(monsterIcon),
        size: const NSize(30, 40),
      );
      trashMarker.setOnTapListener((NMarker marker) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      child: InteractiveViewer(
                          child: Image.network(trashPath[i]['image']))));
            });
      });
      trashMarker.setGlobalZIndex(i);
      _mapController!.addOverlay(trashMarker);
    }
  }

  // marker.setOnTapListener(
  //           (NMarker marker) async => {
  //             if (await marker.hasOpenInfoWindow())
  //               {onMarkerInfoWindow.close()}
  //             else
  //               {marker.openInfoWindow(onMarkerInfoWindow)}
  //           },

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        backgroundColor: AppColors.white,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                  padding: const EdgeInsets.fromLTRB(10, 3, 3, 3),
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: AppColors.help,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.date,
                        style: CustomFontStyle.getTextStyle(
                          context,
                          CustomFontStyle.yeonSung70_white,
                        ),
                      ),
                      Text(
                        widget.time,
                        style: CustomFontStyle.getTextStyle(
                          context,
                          CustomFontStyle.yeonSung60_white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEBF5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.basicgreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        FontAwesomeIcons.circleXmark,
                        size: 40,
                        color: Color(0xFFEEEBF5),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.63,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: historyDetail.isNotEmpty
                      ? NaverMap(
                          onMapReady: (controller) {
                            _mapController = controller; // 지도 컨트롤러 초기화
                            drawPath(); // 경로 그리기
                          },
                          options: NaverMapViewOptions(
                              minZoom: 13,
                              // maxZoom: 16,
                              scaleBarEnable: false,
                              logoAlign: NLogoAlign.leftTop,
                              logoMargin:
                                  const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              initialCameraPosition: NCameraPosition(
                                  target: NLatLng(walkPath[0]['latitude'],
                                      walkPath[0]['longitude']),
                                  zoom: 13,
                                  bearing: 0,
                                  tilt: 45)),
                        )
                      : const CircularProgressIndicator(),
                  // child: Text(
                  //   '$historyDetail',
                  //   style: CustomFontStyle.getTextStyle(
                  //       context, CustomFontStyle.yeonSung50_white),
                  // ),
                ),
              ],
            ),
          ]),
          // actions: <Widget>[
          //   GreenButton(
          //     "취소",
          //     onPressed: () => Navigator.of(context).pop(), // 모달 닫기
          //   ),
          //   RedButton(
          //     "종료",
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //       onConfirm();
          //     },
          //   ),
          // ],
        ));
  }
}
