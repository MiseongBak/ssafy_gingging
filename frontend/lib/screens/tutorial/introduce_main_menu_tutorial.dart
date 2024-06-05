import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/component/menu.dart';
import 'package:frontend/screens/tutorial/introduce_main_pet_tutorial.dart';
import 'dart:math' as math;

class IntroduceMainMenuTutorial extends StatefulWidget {
  const IntroduceMainMenuTutorial({super.key});

  @override
  State<IntroduceMainMenuTutorial> createState() =>
      _IntroduceMainMenuTutorialState();
}

class _IntroduceMainMenuTutorialState extends State<IntroduceMainMenuTutorial>
    with TickerProviderStateMixin {
  AnimationController? _animationController_menu;
  Animation<double>? _scaleAnimation_menu;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();
    _animationController_menu = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation_menu =
        Tween<double>(begin: 1, end: 1.1).animate(_animationController_menu!);

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        buttonCheck = true;
      });
      _animationController_menu!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_menu!.dispose();
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
              return IntroduceMainPetTutorial();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: MediaQuery.of(context).size.width * 0.02,
              child: Container(
                child: Image.asset(AppIcons.earth_3),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(math.pi),
                      child: Image.asset(AppIcons.intro_speak_bubble),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.125,
                      top: MediaQuery.of(context).size.height * 0.08,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '각 메뉴에서',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung80),
                            ),
                            Text(
                              '주간 퀘스트와 랭킹',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung80),
                            ),
                            Text(
                              '히스토리와 플로깅 캠페인의',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung80),
                            ),
                            Text(
                              '정보를 알 수 있어!',
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
            Positioned(
              right: MediaQuery.of(context).size.width * 0.08,
              top: MediaQuery.of(context).size.width * 0.245,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width * 0.84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedBuilder(
                      animation: _scaleAnimation_menu!,
                      builder: (context, widget) {
                        if (_scaleAnimation_menu != null) {
                          return Transform.scale(
                            scale: _scaleAnimation_menu!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Menu(
                        color: AppColors.basicpink,
                        shadowColor: AppColors.basicShadowPink,
                        icon: Icon(
                          FontAwesomeIcons.calendarCheck,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                        content: '주간 퀘스트',
                        isPressed: false,
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.04,
                    // ),
                    AnimatedBuilder(
                      animation: _scaleAnimation_menu!,
                      builder: (context, widget) {
                        if (_scaleAnimation_menu != null) {
                          return Transform.scale(
                            scale: _scaleAnimation_menu!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Menu(
                        color: AppColors.basicgray,
                        shadowColor: AppColors.basicShadowGray,
                        icon: Icon(
                          FontAwesomeIcons.trophy,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                        content: '랭킹',
                        isPressed: false,
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.04,
                    // ),
                    AnimatedBuilder(
                      animation: _scaleAnimation_menu!,
                      builder: (context, widget) {
                        if (_scaleAnimation_menu != null) {
                          return Transform.scale(
                            scale: _scaleAnimation_menu!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Menu(
                        color: AppColors.basicgreen,
                        shadowColor: AppColors.basicShadowGreen,
                        icon: Icon(
                          FontAwesomeIcons.clipboardList,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                        content: '히스토리',
                        isPressed: false,
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.04,
                    // ),
                    AnimatedBuilder(
                      animation: _scaleAnimation_menu!,
                      builder: (context, widget) {
                        if (_scaleAnimation_menu != null) {
                          return Transform.scale(
                            scale: _scaleAnimation_menu!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Menu(
                        color: AppColors.basicnavy,
                        shadowColor: AppColors.basicShadowNavy,
                        icon: Icon(
                          FontAwesomeIcons.users,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                        content: '캠페인',
                        isPressed: false,
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
    ;
  }
}
