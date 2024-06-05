import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/plogging_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/plogging/finishplogging/component/finish_clear_monster_content.dart';
import 'package:frontend/screens/plogging/finishplogging/component/finish_clear_monster_title.dart';
import 'package:provider/provider.dart';

class FinishPloggingDialog extends StatefulWidget {
  final int totalDistance;
  final List<Map<String, double>> path;
  const FinishPloggingDialog({
    super.key,
    required this.path,
    required this.totalDistance,
  });

  @override
  State<FinishPloggingDialog> createState() => _FinishPloggingDialogState();
}

class _FinishPloggingDialogState extends State<FinishPloggingDialog> {
  late UserProvider userProvider;
  late PloggingModel ploggingModel;
  late PloggingProvider ploggingProvider;
  late int totalDistance, plastic, can, glass, normal, value, box;
  late bool isExp;
  late bool isPlogging;
  late String accessToken;
  late Map<String, dynamic> ploggingData, finishData;
  bool isLoadingData = false;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    ploggingModel = Provider.of<PloggingModel>(context, listen: false);
    ploggingProvider = Provider.of<PloggingProvider>(context, listen: false);
    totalDistance = widget.totalDistance;
    accessToken = userProvider.getAccessToken();
    isPlogging = ploggingProvider.isPlogging();
    setPloggingData();
    finishPlogging();
  }

  void setPloggingData() {
    ploggingData = ploggingProvider.getTrashs();
    plastic = ploggingData['plastic'];
    can = ploggingData['can'];
    glass = ploggingData['glass'];
    normal = ploggingData['normal'];
    value = ploggingData['value'];
    box = ploggingData['box'];
    isExp = ploggingData['isExp'];
  }

  void finishPlogging() {
    // 플로깅 유무인지 확인 후 API 보내는 부분
    if (isPlogging) {
      if (totalDistance == 0) {
        totalDistance = 1;
      }
      ploggingModel
          .finishPlogging(accessToken, widget.path, totalDistance)
          .then((res) {
        if (res == 'Success') {
          finishData = ploggingModel.getFinishData();
          Future.delayed(Duration(microseconds: 100), () {
            setState(() {
              isLoadingData = true;
            });
          });
        }
      });
      return;
    }
    // 플로깅 아니라면 데이터 받을 필요 X
    isLoadingData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 차지 안하게
        children: [
          isLoadingData
              ? SizedBox(
                  // color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isPlogging
                          ? FinishClearMonsterTitle(
                              time: finishData['time'],
                            )
                          : Text('몬스터 처치가 없는 원정은 저장되지 않아요'),
                      FinishClearMonsterContent(
                        color: AppColors.basicpink,
                        content: '플라몽',
                        count: plastic,
                      ),
                      FinishClearMonsterContent(
                        color: AppColors.basicgray,
                        content: '포캔몽',
                        count: can,
                      ),
                      FinishClearMonsterContent(
                          color: AppColors.basicgreen,
                          content: '율몽',
                          count: glass),
                      FinishClearMonsterContent(
                        color: AppColors.basicnavy,
                        content: '미쪼몬',
                        count: normal,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen.shade50,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.basicgray.withOpacity(0.5),
                              offset: const Offset(0, 4),
                              blurRadius: 1,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  isExp
                                      ? const Text('EXP :')
                                      : Image.asset(AppIcons.gging),
                                  const Text('+'),
                                  Text('$value'),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(AppIcons.intro_box),
                                  const Text('+'),
                                  Text('$box'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var main =
                              Provider.of<MainProvider>(context, listen: false);
                          main.setIsTutorialPloggingFinish();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            color: AppColors.readyButton,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.basicgray.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '확 인',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung80_white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
