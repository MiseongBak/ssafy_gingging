import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:go_router/go_router.dart';

class BluetoothTutorialDialog extends StatefulWidget {
  const BluetoothTutorialDialog({super.key});

  @override
  State<BluetoothTutorialDialog> createState() =>
      _BluetoothTutorialDialogState();
}

class _BluetoothTutorialDialogState extends State<BluetoothTutorialDialog>
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
              top: MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.width * 0.02,
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
                  child: Image.asset(AppIcons.earth_5),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
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
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Stack(
                    children: [
                      Image.asset(AppIcons.intro_speak_bubble),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.11,
                        top: MediaQuery.of(context).size.height * 0.03,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                '쓰레기 괴물들을',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung90),
                              ),
                              Text(
                                '처치하기 위해서는 무기가 필요해',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung90),
                              ),
                              Text(
                                '일단 집게와',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung90),
                              ),
                              Text(
                                '블루투스를 연결 해 볼까?',
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
            ),
          ],
        ),
      ),
    );
  }
}
