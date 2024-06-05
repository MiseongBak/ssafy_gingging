import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/tutorial/introduce_main_menu_tutorial.dart';
import 'dart:math' as math;

class IntroduceMainSettingTutorial extends StatefulWidget {
  const IntroduceMainSettingTutorial({super.key});

  @override
  State<IntroduceMainSettingTutorial> createState() =>
      _IntroduceMainSettingTutorialState();
}

class _IntroduceMainSettingTutorialState
    extends State<IntroduceMainSettingTutorial> with TickerProviderStateMixin {
  AnimationController? _animationController_setting;
  Animation<double>? _scaleAnimation_setting;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();
    _animationController_setting = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation_setting = Tween<double>(begin: 1, end: 1.1)
        .animate(_animationController_setting!);

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        buttonCheck = true;
      });
      _animationController_setting!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_setting!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (buttonCheck) {
          Navigator.of(context).pop();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return IntroduceMainMenuTutorial();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Image.asset(AppIcons.earth_2)),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
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
                      left: MediaQuery.of(context).size.width * 0.145,
                      top: MediaQuery.of(context).size.height * 0.095,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '설정 버튼을 누르면',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '튜토리얼과 인트로를',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '다시 볼 수 있어!',
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
              right: MediaQuery.of(context).size.width * 0.01,
              top: MediaQuery.of(context).size.width * 0.045,
              child: AnimatedBuilder(
                animation: _scaleAnimation_setting!,
                builder: (context, widget) {
                  if (_scaleAnimation_setting != null) {
                    return Transform.scale(
                      scale: _scaleAnimation_setting!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.basicpink,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 3, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.basicgray.withOpacity(0.5),
                          offset: Offset(0, 4),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.height * 0.08,
                  child: Icon(
                    // mainProvider.isMenuSelected == 'main'
                    //     ? Icons.settings : Icons.home_filled,
                    Icons.settings,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.12,
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
