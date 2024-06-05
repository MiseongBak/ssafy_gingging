import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/main/openbox/open_pet_dialog.dart';
import 'package:frontend/screens/rescue/dialog/check_trashs_dialog.dart';

class RescuePetDialog extends StatefulWidget {
  const RescuePetDialog({super.key});

  @override
  State<RescuePetDialog> createState() => _RescuePetDialogState();
}

class _RescuePetDialogState extends State<RescuePetDialog>
    with TickerProviderStateMixin {
  AnimationController? _animationController_trashs;
  Animation<double>? _rotateAnimation_trashs;

  @override
  void initState() {
    super.initState();

    _animationController_trashs = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _rotateAnimation_trashs =
        Tween<double>(begin: -0.2, end: 0.1).animate(_animationController_trashs!);

    _animationController_trashs!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController_trashs!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: '쓰레기 더미를 터치해주세요!');
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.15,
              child: AnimatedBuilder(
                animation: _animationController_trashs!,
                builder: (context, widget) {
                  if (_rotateAnimation_trashs != null) {
                    return Transform.rotate(
                      angle: _rotateAnimation_trashs!.value,
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
                        return const CheckTrashsDialog();
                      },
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Image.asset(AppIcons.trashs,
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
                      left: MediaQuery.of(context).size.width * 0.08,
                      child: Column(
                        children: [
                          Text(
                            '쓰레기 더미 속에서',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung90),
                          ),
                          Text(
                            '상자를 찾아볼까?!',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung90),
                          ),
                          Text(
                            '쓰레기 더미를 눌러봐!',
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
