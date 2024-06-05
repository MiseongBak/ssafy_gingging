import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class ProfileClearMonsterTitle extends StatefulWidget {
  const ProfileClearMonsterTitle({super.key});

  @override
  State<ProfileClearMonsterTitle> createState() => _ClearMonsterTitleState();
}

class _ClearMonsterTitleState extends State<ProfileClearMonsterTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Container(
            color: Colors.transparent,
            child: Center(
              child: Icon(Icons.flag),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            '처치한 몬스터',
            style:
            CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
          ),
        ],
      ),
    );
  }
}
