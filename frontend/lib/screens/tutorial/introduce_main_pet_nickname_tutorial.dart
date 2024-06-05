import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/main/component/nickname_bar.dart';
import 'package:frontend/screens/tutorial/introduce_main_setting_tutorial.dart';
import 'package:frontend/screens/tutorial/tutorial_finish_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class IntroduceMainPetNicknameTutorial extends StatefulWidget {
  const IntroduceMainPetNicknameTutorial({super.key});

  @override
  State<IntroduceMainPetNicknameTutorial> createState() =>
      _IntroduceMainPetNicknameTutorialState();
}

class _IntroduceMainPetNicknameTutorialState
    extends State<IntroduceMainPetNicknameTutorial>
    with TickerProviderStateMixin {
  late UserProvider userProvider;
  late String accessToken;
  late bool memberTutorial;

  AnimationController? _animationController_pet_nickname;
  Animation<double>? _scaleAnimation_pet_nickname;
  bool buttonCheck = false;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    memberTutorial = userProvider.getMemberTutorial();

    _animationController_pet_nickname = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation_pet_nickname = Tween<double>(begin: 1, end: 1.1)
        .animate(_animationController_pet_nickname!);

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        buttonCheck = true;
      });
      _animationController_pet_nickname!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_pet_nickname!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<PetModel>(context, listen: true).getCurrentPet();

    return GestureDetector(
      onTap: () {
        if (buttonCheck) {
          Navigator.of(context).pop();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TutorialFinishDialog();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: MediaQuery.of(context).size.width * 0.02,
              child: Container(
                child: Image.asset(AppIcons.earth_2),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(AppIcons.intro_speak_bubble),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.165,
                      top: MediaQuery.of(context).size.height * 0.035,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '펫 닉네임을 누르면',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '펫 닉네임을',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung90),
                            ),
                            Text(
                              '변경 할 수도 있어!',
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
            Positioned(
              left: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.83,
              child: AnimatedBuilder(
                animation: _scaleAnimation_pet_nickname!,
                builder: (context, widget) {
                  if (_scaleAnimation_pet_nickname != null) {
                    return Transform.scale(
                      scale: _scaleAnimation_pet_nickname!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: IgnorePointer(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: NickNameBar(
                      nickName: pet['nickname'],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
