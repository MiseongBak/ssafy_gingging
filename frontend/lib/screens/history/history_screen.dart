import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/history/component/history_date_list.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _RankingState();
}

class _RankingState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final histories =
        Provider.of<HistoryModel>(context, listen: true).getHistories();
    List<dynamic> dateHistory = [];
    dateHistory.addAll(histories);

    var groupedByDate = groupBy(dateHistory, (dynamic p) {
      return DateTime.parse(p['create_at'])
          .toIso8601String()
          .substring(0, 10); // 날짜만 추출
    });

    List<dynamic> dateFinalHistory = [];
    for (String key in groupedByDate.keys) {
      dateFinalHistory.add({key: groupedByDate[key]});
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
          ), // 전체 배경
          child: Stack(
            children: [
              Column(
                children: [
                  const TopBar(),
                  dateFinalHistory.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Text(
                              '플로깅을 진행해 주세요!',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            )
                          ],
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: dateFinalHistory.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                // margin: EdgeInsets.only(bottom: 5),
                                child: HistoryDateList(
                                  dateHistoryList: dateFinalHistory[index],
                                ),
                              );
                            },
                          ),
                        )
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: const CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
