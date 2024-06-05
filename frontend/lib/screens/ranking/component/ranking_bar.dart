import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class RankingBar extends StatefulWidget {
  final double heightSize;
  final int exp;

  const RankingBar({
    super.key,
    required this.heightSize,
    required this.exp,
  });

  @override
  State<RankingBar> createState() => _RankingBarState();
}

class _RankingBarState extends State<RankingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 5,
        right: 5,
        left: 5,
      ),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * widget.heightSize,
      decoration: BoxDecoration(
        color: AppColors.basicgreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 3, color: Colors.white),
        boxShadow: [
          BoxShadow(
              color: AppColors.basicgray.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: 1,
              spreadRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            child: Icon(
              FontAwesomeIcons.trophy,
              color: Colors.white,
            ),
          ),
          Text(
            '${widget.exp} exp',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung50_white),
          ),
        ],
      ),
    );
  }
}
