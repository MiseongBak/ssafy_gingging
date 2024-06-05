import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/achievement_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/quest_list.dart';
import 'package:frontend/screens/profile/component/achievement_list.dart';
import 'package:provider/provider.dart';

class AchievementDialog extends StatefulWidget {
  const AchievementDialog({super.key});

  @override
  State<AchievementDialog> createState() => _WeeklyQuestDialogState();
}

class _WeeklyQuestDialogState extends State<AchievementDialog> {
  late AchievementModel achievementModel;
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    achievementModel = Provider.of<AchievementModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    achievementModel.getAchievements(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    final achievements = Provider.of<AchievementModel>(context, listen: true).getAchievement();

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
                  color: AppColors.achievementButton,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '업 적',
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
                    color: AppColors.achievementButton,
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
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: achievements.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: AchievementList(
                    goal: achievements[index]['goal'],
                    progress: achievements[index]['progress'],
                    index: index,
                    memberAchievementId: achievements[index]['member_achievement_id'],
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
