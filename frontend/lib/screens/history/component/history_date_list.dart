import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/history/component/history_list.dart';
import 'package:intl/intl.dart';

class HistoryDateList extends StatefulWidget {
  final Map<String, dynamic> dateHistoryList;

  const HistoryDateList({
    super.key,
    required this.dateHistoryList,
  });

  @override
  State<HistoryDateList> createState() => _HistoryDateListState();
}

class _HistoryDateListState extends State<HistoryDateList> {
  @override
  Widget build(BuildContext context) {
    String originalDateStr = "${widget.dateHistoryList.keys}";
    String cleanedDateStr = originalDateStr.replaceAll(RegExp(r'[()]'), '');
    DateTime date = DateTime.parse(cleanedDateStr);
    String formattedDate = DateFormat('MMMM d일', 'ko_KR').format(date);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.centerLeft,
          child: Text(
            formattedDate,
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung60),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(), // 스크롤 중첩 방지
                shrinkWrap: true,
                itemCount: widget.dateHistoryList.values.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  return HistoryList(
                      historyList: widget.dateHistoryList.values.toList()[0]
                          [index],
                      ploggingId: widget.dateHistoryList.values.toList()[0]
                          [index]['plogging_id'],
                      date: formattedDate,
                      startAt: widget.dateHistoryList.values.toList()[0][index]
                          ['create_at'],
                      finishAt: widget.dateHistoryList.values.toList()[0][index]
                          ['update_at']);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
