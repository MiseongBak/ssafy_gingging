import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/quest_list.dart';
import 'package:provider/provider.dart';

class WeeklyQuestDialog extends StatefulWidget {
  const WeeklyQuestDialog({super.key});

  @override
  State<WeeklyQuestDialog> createState() => _WeeklyQuestDialogState();
}

class _WeeklyQuestDialogState extends State<WeeklyQuestDialog> {
  late QuestModel questModel;
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    questModel = Provider.of<QuestModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    questModel.getQuests(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    final quests = Provider.of<QuestModel>(context, listen: true).getQuest();

    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 자치 안하게
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  color: AppColors.basicpink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '주간 퀘스트',
                    style: CustomFontStyle.getTextStyle(
                      context,
                      CustomFontStyle.yeonSung80_white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEBF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.basicpink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.circleXmark,
                      size: 41,
                      color: Color(0xFFEEEBF5),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.21,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: quests.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: QuestList(
                    goal: quests[index]['goal'],
                    progress: quests[index]['progress'],
                    index: index,
                    questId: quests[index]['quest_id'],
                    memberQuestId: quests[index]['member_quest_id'],
                    petNickName: quests[index]['pet_nickname'],
                    done: quests[index]['done'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // actions: <Widget>[
      //   GreenButton(
      //     "취소",
      //     onPressed: () => Navigator.of(context).pop(), // 모달 닫기
      //   ),
      //   RedButton(
      //     "종료",
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //       onConfirm();
      //     },
      //   ),
      // ],
    );
  }
}
