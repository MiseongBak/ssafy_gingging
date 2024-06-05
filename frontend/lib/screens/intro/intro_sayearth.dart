import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class IntroSayEarth extends StatefulWidget {
  const IntroSayEarth({super.key});

  @override
  State<IntroSayEarth> createState() => _IntroSayEarthState();
}

class _IntroSayEarthState extends State<IntroSayEarth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * -0.1,
            bottom: MediaQuery.of(context).size.height * 0.15,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.earth_1,
                    width: MediaQuery.of(context).size.width * 0.8),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * -0.05,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.intro_speak_bubble,
                    width: MediaQuery.of(context).size.width * 1),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.25,
            top: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              color: Colors.transparent,
              child: Center(
                  child: Text(
                '도와줘!!',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung200),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
