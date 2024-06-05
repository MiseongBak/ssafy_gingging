import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class ProfileClearMonsterContent extends StatefulWidget {
  final Color color;
  final String content;
  final int count;
  final Image monster;

  const ProfileClearMonsterContent({
    super.key,
    required this.color,
    required this.content,
    required this.count,
    required this.monster,
  });

  @override
  State<ProfileClearMonsterContent> createState() =>
      _ClearMonsterContentState();
}

class _ClearMonsterContentState extends State<ProfileClearMonsterContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: Offset(0, 4),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                child: widget.monster,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                widget.content,
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${widget.count}',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                '마리',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
