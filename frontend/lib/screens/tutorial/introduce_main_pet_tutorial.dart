import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/main/partner/partner.dart';
import 'package:frontend/screens/tutorial/introduce_main_pet_nickname_tutorial.dart';
import 'dart:math' as math;

class IntroduceMainPetTutorial extends StatefulWidget {
  const IntroduceMainPetTutorial({super.key});

  @override
  State<IntroduceMainPetTutorial> createState() =>
      _IntroduceMainPetTutorialState();
}

class _IntroduceMainPetTutorialState extends State<IntroduceMainPetTutorial>
    with TickerProviderStateMixin {
  AnimationController? _animationController_pet;
  Animation<double>? _scaleAnimation_pet;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();
    _animationController_pet = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation_pet =
        Tween<double>(begin: 1, end: 1.1).animate(_animationController_pet!);

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        buttonCheck = true;
      });
      _animationController_pet!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_pet!.dispose();
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
              return IntroduceMainPetNicknameTutorial();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              // right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.width * 0.45,
              child: AnimatedBuilder(
                animation: _scaleAnimation_pet!,
                builder: (context, widget) {
                  if (_scaleAnimation_pet != null) {
                    return Transform.scale(
                      scale: _scaleAnimation_pet!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: IgnorePointer(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    // color: Colors.white,
                    child: Partner(
                      image: Image.asset(AppIcons.sudal),
                      isPet: true,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              right: MediaQuery.of(context).size.width * 0.02,
              child: Container(
                child: Image.asset(AppIcons.earth_2),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.01,
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
                      left: MediaQuery.of(context).size.width * 0.165,
                      top: MediaQuery.of(context).size.height * 0.09,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '펫을 누르면',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '내가 원하는 펫을',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '확인할 수 있고',
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
