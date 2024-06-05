import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/history/dialog/history_detail_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatefulWidget {
  final Map<String, dynamic> historyList;
  final int ploggingId;
  final String date;
  final String startAt;
  final String finishAt;

  const HistoryList({
    super.key,
    required this.historyList,
    required this.ploggingId,
    required this.date,
    required this.startAt,
    required this.finishAt,
  });

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dateStartTimeStr = widget.startAt;
    String dateFinishTimeStr = widget.finishAt;
    DateTime dateStartTime = DateTime.parse(dateStartTimeStr);
    String formattedStartTime =
        DateFormat('a h:mm', 'ko_KR').format(dateStartTime);
    DateTime dateFinishTime = DateTime.parse(dateFinishTimeStr);
    String formattedFinishTime =
        DateFormat('a h:mm', 'ko_KR').format(dateFinishTime);

    // formattedStartTime.replaceAll('AM', '오전');
    // formattedStartTime.replaceAll('PM', '오후');
    // formattedFinishTime.replaceAll('AM', '오전');
    // formattedFinishTime.replaceAll('PM', '오후');
    var allPets = Provider.of<PetModel>(context, listen: true).getAllPet();

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                    color: AppColors.basicShadowGreen,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.white),
                    boxShadow: _isPressed
                        ? []
                        : [
                            BoxShadow(
                              color: AppColors.basicgray.withOpacity(0.5),
                              offset: const Offset(0, 4),
                              blurRadius: 1,
                              spreadRadius: 1,
                            )
                          ]),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.004,
                left: MediaQuery.of(context).size.height * 0.004,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 3, 0),
                  width: MediaQuery.of(context).size.width * 0.884,
                  height: MediaQuery.of(context).size.height * 0.075,
                  decoration: BoxDecoration(
                    color: AppColors.basicgreen,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: ProfileImage(
                          image: allPets[widget.historyList['pet_id'] - 1]
                                  ['active']
                              ? Image.network(
                                  allPets[widget.historyList['pet_id'] - 1]
                                      ['image'])
                              : Image.asset(AppIcons.intro_box),
                          isPressed: false,
                        ), // 같이 간 펫
                      ),
                      Column(
                        children: [
                          Text(
                            '총 거리',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung60_white,
                            ),
                          ),
                          Text(
                            '${widget.historyList['distance'] / 1000} KM',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung80_white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '처치한 몬스터 수',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung60_white,
                            ),
                          ),
                          Text(
                            '${widget.historyList['trash_count']} 마리',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung80_white,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          var historyModel =
                              Provider.of<HistoryModel>(context, listen: false);
                          await historyModel.getHistoryDetail(
                              accessToken, widget.ploggingId);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return HistoryDetailDialog(
                                date: widget.date,
                                time:
                                    '$formattedStartTime ~ $formattedFinishTime',
                              );
                            },
                          );
                        },
                        onTapDown: _onTapDown,
                        onTapUp: _onTapUp,
                        onTapCancel: _onTapCancel,
                        child: Column(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.height * 0.051,
                            ),
                            Text(
                              '상세정보',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung50_white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
