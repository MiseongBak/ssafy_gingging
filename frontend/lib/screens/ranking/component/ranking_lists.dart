import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/ranking/component/ranking_list.dart';

class RankingLists extends StatefulWidget {
  final List people;

  const RankingLists({
    super.key,
    required this.people,
  });

  @override
  State<RankingLists> createState() => _RankingListState();
}

class _RankingListState extends State<RankingLists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.07,
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.005,
                  child: Text(
                    '순위',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung60),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.16,
                  child: Text('유저',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60)),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Text('경험치',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60)),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            // color: Colors.yellow,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.people.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // margin: EdgeInsets.only(bottom: 5),
                  child: RankingList(
                    rank: index + 4,
                    nickName: widget.people[index]['nickname'],
                    score: widget.people[index]['exp'],
                    profile: widget.people[index]['profile_pet_id'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
