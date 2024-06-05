import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/achievement_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/profile/dialog/get_achievement_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AchievementList extends StatefulWidget {
  final int goal;
  final int progress;
  final int index;
  final int memberAchievementId;

  const AchievementList({
    super.key,
    required this.goal,
    required this.progress,
    required this.index,
    required this.memberAchievementId,
  });

  @override
  State<AchievementList> createState() => _AchievementListState();
}

class _AchievementListState extends State<AchievementList>
    with TickerProviderStateMixin {
  late UserProvider userProvider;
  late AchievementModel achievementModel;
  late String accessToken;

  AnimationController? _animationController_intersect;
  Animation<double>? _rotateAnimation_intersect;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    achievementModel = Provider.of<AchievementModel>(context, listen: false);
    accessToken = userProvider.getAccessToken();

    _animationController_intersect = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    _rotateAnimation_intersect = Tween<double>(begin: 1, end: 10)
        .animate(_animationController_intersect!);

    _animationController_intersect!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController_intersect!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currency =
        Provider.of<UserProvider>(context, listen: true).getCurrency();
    late int GoalDistance;
    late int ProgressDistance;
    if (widget.index == 1) {
      GoalDistance = (widget.goal / 1000).floor();
      ProgressDistance = (widget.progress / 1000).floor();
    }

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: AppColors.basicgray,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                  color: AppColors.basicgray.withOpacity(0.5),
                  offset: Offset(0, 4),
                  blurRadius: 1,
                  spreadRadius: 1)
            ],
          ),
          child: Text(
            widget.index == 0
                ? widget.goal > 80
                    ? '이미 모든 업적 펫을 획득 하였습니다.'
                    : '플로깅 원정 ${widget.goal}회 출정하기'
                : widget.index == 1
                    ? '원정 거리 ${GoalDistance}Km 주파'
                    : widget.index == 2
                        ? '펫 ${widget.goal}종 모집'
                        : widget.index == 3
                            ? '미쪼몬 ${widget.goal}마리 처치 하기'
                            : widget.index == 4
                                ? '플라몽 ${widget.goal}마리 처치 하기'
                                : widget.index == 5
                                    ? '포 캔몽 ${widget.goal}마리 처치 하기'
                                    : '율몽 ${widget.goal}마리 처치 하기',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung60_white),
          ),
        ),
        widget.goal > widget.progress
            ? Positioned(
                top: MediaQuery.of(context).size.height * 0.015,
                right: MediaQuery.of(context).size.width * 0.02,
                child: Container(
                  child: Text(
                    widget.index == 1
                        ? '$ProgressDistance/$GoalDistance'
                        : '${widget.progress}/${widget.goal}',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung60_white),
                  ),
                ),
              )
            : widget.index == 0 && widget.goal > 80
                ? Container()
                : Positioned(
                    right: 0,
                    child: AnimatedBuilder(
                      animation: _animationController_intersect!,
                      builder: (context, widget) {
                        if (_rotateAnimation_intersect != null) {
                          return Transform.rotate(
                            angle: _rotateAnimation_intersect!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: GestureDetector(
                        onTap: () async {
                          final achievements = Provider.of<AchievementModel>(
                              context,
                              listen: false);
                          await achievements.completeAchievement(
                              accessToken, widget.memberAchievementId);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return GetAchievementDialog(index: widget.index);
                            },
                          );
                          achievementModel.getAchievements(accessToken);
                          if (widget.index != 0 && widget.index != 2) {
                            userProvider.setCurrency(currency + 5000);
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Image.asset(AppIcons.intersect,
                              width: MediaQuery.of(context).size.width * 0.11),
                        ),
                      ),
                    ),
                  ),
        if (widget.goal <= widget.progress)
          widget.index == 0 || widget.index == 2
              ? widget.goal > 80
                  ? Container()
                  : Positioned(
                      top: MediaQuery.of(context).size.height * 0.0155,
                      right: MediaQuery.of(context).size.width * 0.015,
                      child: IgnorePointer(
                        child: Container(
                          child: Image.asset(AppIcons.intro_box,
                              width: MediaQuery.of(context).size.width * 0.08),
                        ),
                      ),
                    )
              : Positioned(
                  top: MediaQuery.of(context).size.height * 0.0155,
                  right: MediaQuery.of(context).size.width * 0.022,
                  child: IgnorePointer(
                    child: Container(
                      child: Image.asset(AppIcons.gging,
                          width: MediaQuery.of(context).size.width * 0.06),
                    ),
                  ),
                ),
      ],
    );
  }
}
