import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class TutorialFinishDialog extends StatefulWidget {
  const TutorialFinishDialog({super.key});

  @override
  State<TutorialFinishDialog> createState() => _TutorialFinishDialogState();
}

class _TutorialFinishDialogState extends State<TutorialFinishDialog>
    with TickerProviderStateMixin {
  late UserProvider userProvider;
  late String accessToken;
  late bool memberTutorial;

  AnimationController? _animationController_earth;
  Animation<double>? _rotateAnimation_earth;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    memberTutorial = userProvider.getMemberTutorial();

    _animationController_earth = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _rotateAnimation_earth = Tween<double>(begin: -0.15, end: 0.15)
        .animate(_animationController_earth!);

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        buttonCheck = true;
      });
      _animationController_earth!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_earth!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        if (memberTutorial == false) {
          final member = Provider.of<MemberModel>(context, listen: false);
          member.finishTutorial(accessToken);
          userProvider.setMemberTutorial(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.25,
              left: MediaQuery.of(context).size.width * 0.01,
              child: AnimatedBuilder(
                animation: _animationController_earth!,
                builder: (context, widget) {
                  if (_rotateAnimation_earth != null) {
                    return Transform.rotate(
                      angle: _rotateAnimation_earth!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: Container(
                  child: Image.asset(AppIcons.earth_3),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Stack(
                  children: [
                    Image.asset(AppIcons.intro_speak_bubble),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.165,
                      top: MediaQuery.of(context).size.height * 0.035,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '꾸준히 플로깅을 해서',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '동물들고 구해주고',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '지구를 지켜줘!',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
