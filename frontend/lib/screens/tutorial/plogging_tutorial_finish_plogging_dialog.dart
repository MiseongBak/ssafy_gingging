import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/plogging/progressplogging/component/finishcheck_plogging.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

class PloggingTutorialFinishPloggingDialog extends StatefulWidget {
  final Function onConfirm;

  const PloggingTutorialFinishPloggingDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<PloggingTutorialFinishPloggingDialog> createState() =>
      _PloggingTutorialFinishPloggingDialogState();
}

class _PloggingTutorialFinishPloggingDialogState
    extends State<PloggingTutorialFinishPloggingDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: '종료버튼을 눌러주세요!');
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.width * 0.03,
              child: Container(
                child: Image.asset(AppIcons.earth_2),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(AppIcons.intro_speak_bubble),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.085,
                      top: MediaQuery.of(context).size.height * 0.045,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '종료버튼을 눌러서',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '플로깅을 종료 해보자!',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.height * 0.005,
              child: GestureDetector(
                onTap: () {
                  // context.pushReplacement('/main');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FinishCheckPloggingDialog(
                        onConfirm: () {
                          Navigator.of(context).pop();
                          widget.onConfirm();
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  width: MediaQuery.of(context).size.width * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      '종 료',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung70_white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
