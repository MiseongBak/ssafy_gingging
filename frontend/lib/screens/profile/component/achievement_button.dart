import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class AchievementButton extends StatefulWidget {
  final bool isPressed;

  const AchievementButton({
    super.key,
    required this.isPressed,
  });

  @override
  State<AchievementButton> createState() => _AchievementButtonState();
}

class _AchievementButtonState extends State<AchievementButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: AppColors.achievementButton,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 3, color: Colors.white),
        boxShadow: widget.isPressed ? [] : [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: Offset(0, 4),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.014,
            left: MediaQuery.of(context).size.width * 0.02,
            child: Container(
              child: Icon(
                FontAwesomeIcons.medal,
                size: 23,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              '     업 적',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung60_white),
            ),
          ),
        ],
      ),
    );
  }
}
