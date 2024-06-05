import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/main/openbox/open_pet_dialog.dart';
import 'package:frontend/screens/tutorial/introduce_main_menu_tutorial.dart';
import 'package:frontend/screens/tutorial/introduce_main_pet_nickname_tutorial.dart';
import 'package:frontend/screens/tutorial/introduce_main_pet_tutorial.dart';
import 'package:frontend/screens/tutorial/introduce_main_profile_tutorial.dart';
import 'package:frontend/screens/tutorial/introduce_main_setting_tutorial.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OpenBoxDialog extends StatefulWidget {
  final String image;

  const OpenBoxDialog({
    super.key,
    required this.image,
  });

  @override
  State<OpenBoxDialog> createState() => _OpenBoxDialogState();
}

class _OpenBoxDialogState extends State<OpenBoxDialog>
    with TickerProviderStateMixin {
  late UserProvider userProvider;
  late String accessToken;
  late bool memberTutorial;

  AnimationController? _animationController_box;
  Animation<double>? _rotateAnimation_box;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    memberTutorial = userProvider.getMemberTutorial();

    _animationController_box = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _rotateAnimation_box =
        Tween<double>(begin: -0.1, end: 0.1).animate(_animationController_box!);

    _animationController_box!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController_box!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: '상자를 터치해주세요!');
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.26,
              left: MediaQuery.of(context).size.width * 0.15,
              child: AnimatedBuilder(
                animation: _animationController_box!,
                builder: (context, widget) {
                  if (_rotateAnimation_box != null) {
                    return Transform.rotate(
                      angle: _rotateAnimation_box!.value,
                      child: widget,
                    );
                  } else {
                    return Container();
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return OpenPetDialog(image: widget.image);
                      },
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Image.asset(AppIcons.intro_box,
                          width: MediaQuery.of(context).size.width * 0.7),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                // color: Colors.black,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(AppIcons.earth_3),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.23,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Stack(
                  children: [
                    Image.asset(AppIcons.intro_speak_bubble),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.1,
                      child: Column(
                        children: [
                          Text(
                            '상자에서',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung90),
                          ),
                          Text(
                            '동료가 나오려고 해!',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung90),
                          ),
                          Text(
                            '상자를 눌러볼까?',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung90),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
