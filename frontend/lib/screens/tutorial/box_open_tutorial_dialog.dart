import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/main/openbox/open_pet_dialog.dart';

class BoxOpenTutorialDialog extends StatefulWidget {
  const BoxOpenTutorialDialog({super.key});

  @override
  State<BoxOpenTutorialDialog> createState() => _BoxOpenTutorialDialogState();
}

class _BoxOpenTutorialDialogState extends State<BoxOpenTutorialDialog>
    with TickerProviderStateMixin {
  AnimationController? _animationController_earth;
  Animation<double>? _scaleAnimation_earth;
  AnimationController? _animationController_speak_bubble;
  Animation<double>? _scaleAnimation_speak_bubble;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();

    _animationController_earth = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_earth =
        Tween<double>(begin: 0, end: 1).animate(_animationController_earth!);

    _animationController_speak_bubble = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_speak_bubble = Tween<double>(begin: 0, end: 1)
        .animate(_animationController_speak_bubble!);

    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController_earth!.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController_speak_bubble!.forward();
    });
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
        if (buttonCheck) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.26,
              left: MediaQuery.of(context).size.width * 0.15,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_box,
                      width: MediaQuery.of(context).size.width * 0.7),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: AnimatedBuilder(
                animation: _scaleAnimation_earth!,
                builder: (context, widget) {
                  if (_scaleAnimation_earth != null) {
                    return Transform.scale(
                      scale: _scaleAnimation_earth!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(AppIcons.earth_3),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.23,
              right: MediaQuery.of(context).size.width * 0.1,
              child: AnimatedBuilder(
                animation: _scaleAnimation_speak_bubble!,
                builder: (context, widget) {
                  if (_scaleAnimation_speak_bubble != null) {
                    return Transform.scale(
                      scale: _scaleAnimation_speak_bubble!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Stack(
                    children: [
                      Image.asset(AppIcons.intro_speak_bubble),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.014,
                        left: MediaQuery.of(context).size.width * 0.18,
                        child: Column(
                          children: [
                            Text(
                              '플로깅을 통해',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '몬스터를 해치우면',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '경험치를 얻어서',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '상자를 열 수 있어!',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
