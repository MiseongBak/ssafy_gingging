import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/tutorial/introduce_main_setting_tutorial.dart';
import 'dart:math' as math;

class IntroduceMainProfileTutorial extends StatefulWidget {
  const IntroduceMainProfileTutorial({super.key});

  @override
  State<IntroduceMainProfileTutorial> createState() =>
      _IntroduceMainProfileTutorialState();
}

class _IntroduceMainProfileTutorialState
    extends State<IntroduceMainProfileTutorial> with TickerProviderStateMixin {
  AnimationController? _animationController_profile;
  Animation<double>? _scaleAnimation_profile;
  AnimationController? _animationController_earth;
  Animation<double>? _scaleAnimation_earth;
  AnimationController? _animationController_speak_bubble;
  Animation<double>? _scaleAnimation_speak_bubble;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();
    _animationController_profile = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation_profile = Tween<double>(begin: 1, end: 1.1)
        .animate(_animationController_profile!);

    _animationController_earth = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_earth =
        Tween<double>(begin: 0, end: 1).animate(_animationController_earth!);

    _animationController_speak_bubble = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_speak_bubble = Tween<double>(begin: 0, end: 1)
        .animate(_animationController_speak_bubble!);

    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_earth!.forward();
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_speak_bubble!.forward();
    });
    Future.delayed(const Duration(milliseconds: 2400), () {
      setState(() {
        buttonCheck = true;
      });
      _animationController_profile!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_earth!.dispose();
    _animationController_speak_bubble!.dispose();
    _animationController_profile!.dispose();
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
              return IntroduceMainSettingTutorial();
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
              left: MediaQuery.of(context).size.width * 0.01,
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
                  child: Image.asset(AppIcons.earth_2),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.35,
              right: MediaQuery.of(context).size.width * 0.01,
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
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Stack(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(math.pi),
                        child: Image.asset(AppIcons.intro_speak_bubble),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.08,
                        top: MediaQuery.of(context).size.height * 0.095,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                '프로필 사진을 누르면 내 정보에서',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung80),
                              ),
                              Text(
                                '프로필 사진을 변경할 수 있고',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung80),
                              ),
                              Text(
                                '업적 달성을 확인하고',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung80),
                              ),
                              Text(
                                '낑으로 펫을 구출 할 수 있어',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung80),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buttonCheck
                ? Positioned(
                    left: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.width * 0.04,
                    child: AnimatedBuilder(
                      animation: _scaleAnimation_profile!,
                      builder: (context, widget) {
                        if (_scaleAnimation_profile != null) {
                          return Transform.scale(
                            scale: _scaleAnimation_profile!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
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
                        child: ClipRRect(
                          // 자식 위젯을 둥글게 클리핑
                          borderRadius: BorderRadius.circular(40),
                          // 여기서도 컨테이너의 borderRadius와 동일하게 설정
                          child: Image.asset(AppIcons.earth_3), // 이곳에 프로필 이미지 위젯을 삽입
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
