import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/plogging/readyplogging/component/ready_map.dart';
import 'package:go_router/go_router.dart';

class ConfirmMapDialog extends StatefulWidget {
  const ConfirmMapDialog({super.key});

  @override
  State<ConfirmMapDialog> createState() => _ConfirmMapDialogState();
}

class _ConfirmMapDialogState extends State<ConfirmMapDialog>
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
  void dispose() {
    _animationController_earth!.dispose();
    _animationController_speak_bubble!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Container(
              color: Colors.white,
              child: buttonCheck ? ReadyMap() : Container(),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.2,
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
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset(AppIcons.earth_5),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.4,
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
                width: MediaQuery.of(context).size.width * 0.5,
                child: Stack(
                  children: [
                    Image.asset(AppIcons.intro_speak_bubble),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.07,
                      top: MediaQuery.of(context).size.height * 0.025,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '지도를 보면 내 위치와',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung70),
                            ),
                            Text(
                              '내 주변 쓰레기통 정보를',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung70),
                            ),
                            Text(
                              '볼 수 있어!',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung70),
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
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                if (buttonCheck) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
