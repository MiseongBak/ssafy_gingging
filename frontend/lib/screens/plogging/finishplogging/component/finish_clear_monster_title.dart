import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:intl/intl.dart';

class FinishClearMonsterTitle extends StatefulWidget {
  final String time;
  const FinishClearMonsterTitle({super.key, required this.time});

  @override
  State<FinishClearMonsterTitle> createState() =>
      _FinishClearMonsterTitleState();
}

class _FinishClearMonsterTitleState extends State<FinishClearMonsterTitle> {
  @override
  Widget build(BuildContext context) {
    String convertTime(String time24) {
      final format24 = DateFormat('HH:mm');
      final format12 = DateFormat('a hh:mm');

      DateTime dateTime = format24.parse(time24);
      String time12 = format12.format(dateTime); // 'a'는 AM/PM을 나타내며, toLowerCase()로 소문자 am/pm으로 변경
      return time12;
    }

    String timeStart24 = widget.time.split('~').first.trim();
    String timeEnd24 = widget.time.split('~').last.trim();
    String timeStart12 = convertTime(timeStart24);
    String timeEnd12 = convertTime(timeEnd24);

    print('시간이요 ${widget.time.split('~').first.trim()}');

    return Container(
      padding: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Center(
            child: Text(
              '$timeStart12 ~ $timeEnd12',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung70),
            ),
          ),
        ],
      ),
    );
  }
}
