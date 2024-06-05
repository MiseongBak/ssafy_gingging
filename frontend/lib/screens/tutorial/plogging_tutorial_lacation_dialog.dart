import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/tutorial/introduce_main_setting_tutorial.dart';
import 'dart:math' as math;

class PloggingTutorialLocationDialog extends StatefulWidget {
  const PloggingTutorialLocationDialog({super.key});

  @override
  State<PloggingTutorialLocationDialog> createState() =>
      _PloggingTutorialLocationDialog();
}

class _PloggingTutorialLocationDialog
    extends State<PloggingTutorialLocationDialog>
    with TickerProviderStateMixin {
  AnimationController? _animationController_location;
  Animation<double>? _scaleAnimation_location;
  AnimationController? _animationController_earth;
  Animation<double>? _scaleAnimation_earth;
  AnimationController? _animationController_speak_bubble;
  Animation<double>? _scaleAnimation_speak_bubble;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();
    _animationController_location = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation_location = Tween<double>(begin: 1, end: 1.1)
        .animate(_animationController_location!);

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
      _animationController_location!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_earth!.dispose();
    _animationController_speak_bubble!.dispose();
    _animationController_location!.dispose();
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
              bottom: MediaQuery.of(context).size.height * 0.23,
              right: MediaQuery.of(context).size.width * 0.01,
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
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Image.asset(AppIcons.earth_2),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              left: MediaQuery.of(context).size.width * 0.01,
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
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.asset(AppIcons.intro_speak_bubble),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.2,
                        top: MediaQuery.of(context).size.height * 0.04,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                '지도에',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung80),
                              ),
                              Text(
                                '현재 내 위치가',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung80),
                              ),
                              Text(
                                '표시 돼!',
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
                    left: MediaQuery.of(context).size.width * 0.425,
                    top: MediaQuery.of(context).size.width * 0.965,
                    child: AnimatedBuilder(
                      animation: _scaleAnimation_location!,
                      builder: (context, widget) {
                        if (_scaleAnimation_location != null) {
                          return Transform.scale(
                            scale: _scaleAnimation_location!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.148,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(AppIcons.intro_box),
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
