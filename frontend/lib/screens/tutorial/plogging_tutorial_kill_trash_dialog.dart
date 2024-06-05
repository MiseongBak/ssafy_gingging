import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_box_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_finish_plogging_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_box_dialog.dart';
import 'dart:math' as math;

class PloggingTutorialKillTrashDialog extends StatefulWidget {
  final String displayMonster;
  final String monsterIcon;
  final Function onConfirm;

  const PloggingTutorialKillTrashDialog({
    super.key,
    required this.displayMonster,
    required this.monsterIcon,
    required this.onConfirm,
  });

  @override
  State<PloggingTutorialKillTrashDialog> createState() =>
      _PloggingTutorialKillTrashDialogState();
}

class _PloggingTutorialKillTrashDialogState
    extends State<PloggingTutorialKillTrashDialog> {
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        buttonCheck = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PloggingTutorialBoxDialog(onConfirm: widget.onConfirm);
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Container(
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Image.asset(AppIcons.earth_2)),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(math.pi),
                        child: Image.asset(AppIcons.intro_speak_bubble),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.09,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '${widget.displayMonster}을',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '한 마리 처치 했어!',
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
                        width: MediaQuery.of(context).size.width * 0.09,
                        height: MediaQuery.of(context).size.height * 0.04,
                        // color: Colors.black,
                        child: Image.asset(widget.monsterIcon),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.width * 0.02,
                      child: Text(
                        '${widget.displayMonster} 처치 + 1',
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
          ],
        ),
      ),
    );
  }
}
