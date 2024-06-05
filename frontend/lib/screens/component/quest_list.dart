import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/main/dialog/get_quest_achievement_dialog.dart';
import 'package:provider/provider.dart';

class QuestList extends StatefulWidget {
  final int goal;
  final int progress;
  final int index;
  final int questId;
  final int memberQuestId;
  final String petNickName;
  final bool done;

  const QuestList({
    super.key,
    required this.goal,
    required this.progress,
    required this.index,
    required this.memberQuestId,
    required this.questId,
    required this.petNickName,
    required this.done,
  });

  @override
  State<QuestList> createState() => _QuestListState();
}

class _QuestListState extends State<QuestList> with TickerProviderStateMixin {
  late UserProvider userProvider;
  late QuestModel questModel;
  late String accessToken;
  late int currency;

  AnimationController? _animationController_intersect;
  Animation<double>? _rotateAnimation_intersect;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    questModel = Provider.of<QuestModel>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    currency = userProvider.getCurrency();

    _animationController_intersect = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    _rotateAnimation_intersect = Tween<double>(begin: 1, end: 10)
        .animate(_animationController_intersect!);

    _animationController_intersect!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    int lastChar = widget.petNickName.codeUnitAt(widget.petNickName.length - 1);
    int index = (lastChar - 0xAC00) % 28;

    var petNickName =
        index == 0 ? widget.petNickName + "와" : widget.petNickName + "과";

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
            widget.questId == 1
                ? '$petNickName 플로깅 ${widget.goal}회 하기'
                : widget.questId == 2
                    ? '$petNickName 플라몽 ${widget.goal}마리 처치 하기'
                    : widget.questId == 3
                        ? '$petNickName 미쪼몬 ${widget.goal}마리 처치 하기'
                        : widget.questId == 4
                            ? '$petNickName 율몽 ${widget.goal}마리 처치 하기'
                            : '$petNickName 포 캔몽 ${widget.goal}마리 처치 하기',
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
                    '${widget.progress}/${widget.goal}',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung60_white),
                  ),
                ),
              )
            : widget.done
                ? Positioned(
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.01,
                    child: Text(
                      '완료',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60_white),
                    ),
                  )
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
                          final quests =
                              Provider.of<QuestModel>(context, listen: false);
                          await quests.completeQuest(
                              accessToken, widget.memberQuestId);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return GetQuestAchievementDialog();
                            },
                          );
                          questModel.getQuests(accessToken);
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
          widget.done
              ? Container()
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
