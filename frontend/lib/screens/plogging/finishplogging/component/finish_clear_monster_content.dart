import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class FinishClearMonsterContent extends StatefulWidget {
  final Color color;
  final String content;
  final int count;

  const FinishClearMonsterContent({
    super.key,
    required this.color,
    required this.content,
    required this.count,
  });

  @override
  State<FinishClearMonsterContent> createState() =>
      _FinishClearMonsterContent();
}

class _FinishClearMonsterContent extends State<FinishClearMonsterContent> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.content,
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung60_white),
          ),
          Text(
            '${widget.count}마리',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung60_white),
          )
        ],
      ),
    );
  }
}
