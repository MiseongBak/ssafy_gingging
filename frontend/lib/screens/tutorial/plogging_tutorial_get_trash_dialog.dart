import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class PloggingTutorialGetTrashDialog extends StatefulWidget {
  const PloggingTutorialGetTrashDialog({super.key});

  @override
  State<PloggingTutorialGetTrashDialog> createState() =>
      _PloggingTutorialGetTrashDialogState();
}

class _PloggingTutorialGetTrashDialogState
    extends State<PloggingTutorialGetTrashDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                child: Image.asset(AppIcons.earth_5),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Stack(
                  children: [
                    Image.asset(AppIcons.intro_speak_bubble),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.2,
                      top: MediaQuery.of(context).size.height * 0.052,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '쓰레기를',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '한번 주워 볼까?',
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
          ],
        ),
      ),
    );
  }
}
