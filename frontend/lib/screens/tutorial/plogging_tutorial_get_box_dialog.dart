import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'dart:math' as math;

import 'package:frontend/screens/tutorial/plogging_tutorial_finish_plogging_dialog.dart';

class PloggingTutorialGetBoxDialog extends StatefulWidget {
  final Function onConfirm;

  const PloggingTutorialGetBoxDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<PloggingTutorialGetBoxDialog> createState() =>
      _PloggingTutorialGetBoxDialogState();
}

class _PloggingTutorialGetBoxDialogState
    extends State<PloggingTutorialGetBoxDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PloggingTutorialFinishPloggingDialog(onConfirm: widget.onConfirm,);
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
                      left: MediaQuery.of(context).size.width * 0.19,
                      top: MediaQuery.of(context).size.height * 0.09,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '상자를',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '획득 했어!',
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
                      left: MediaQuery.of(context).size.height * 0.004,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.09,
                        height: MediaQuery.of(context).size.height * 0.04,
                        // color: Colors.black,
                        child: Image.asset(AppIcons.intro_box),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.width * 0.02,
                      child: Text(
                        '상자 획득 + 1',
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
