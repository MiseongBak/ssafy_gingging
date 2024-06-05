import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class ClearMonsterTitle extends StatefulWidget {
  final String petNickname;

  const ClearMonsterTitle({
    super.key,
    required this.petNickname,
  });

  @override
  State<ClearMonsterTitle> createState() => _ClearMonsterTitleState();
}

class _ClearMonsterTitleState extends State<ClearMonsterTitle> {
  @override
  Widget build(BuildContext context) {
    int lastChar = widget.petNickname.codeUnitAt(widget.petNickname.length - 1);
    int index = (lastChar - 0xAC00) % 28;

    var petNickName =
    index == 0 ? widget.petNickname + "와" : widget.petNickname + "과";

    return Container(
      padding: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
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
            '펫과 함께 처치한 몬스터',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung70),
          ),
        ],
      ),
    );
  }
}
