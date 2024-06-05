import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:provider/provider.dart';

class GetQuestAchievementDialog extends StatefulWidget {
  const GetQuestAchievementDialog({
    super.key,
  });

  @override
  State<GetQuestAchievementDialog> createState() =>
      _GetQuestAchievementDialogState();
}

class _GetQuestAchievementDialogState extends State<GetQuestAchievementDialog>
    with TickerProviderStateMixin {
  bool _isFinish = false;

  AnimationController? _animationController_intersect;
  Animation<double>? _rotateAnimation_intersect;
  AnimationController? _animationController_achievement;
  Animation<double>? _scaleAnimation_achievement;

  @override
  void initState() {
    super.initState();

    _animationController_intersect = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    _rotateAnimation_intersect = Tween<double>(begin: 1, end: 10)
        .animate(_animationController_intersect!);

    _animationController_achievement = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_achievement = Tween<double>(begin: 0, end: 1)
        .animate(_animationController_achievement!);

    _animationController_intersect!.repeat(reverse: true);
    _animationController_achievement!.forward();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isFinish = !_isFinish;
      });
    });
  }

  @override
  void dispose() {
    _animationController_intersect!.dispose();
    _animationController_achievement!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gging = Provider.of<QuestModel>(context, listen: true).getGging();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          children: [
            AnimatedBuilder(
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
              child: Container(
                child: Center(
                  child: Image.asset(AppIcons.big_intersect),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animationController_achievement!,
              builder: (context, widget) {
                if (_scaleAnimation_achievement != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_achievement!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(
                    AppIcons.gging,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: 0,
              child: Container(
                // color: Colors.black,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                  child: _isFinish
                      ? Text(
                          '$gging 낑을 획득하였습니다!',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung90_white),
                        )
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
