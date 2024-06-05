import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/rescue_model.dart';
import 'package:provider/provider.dart';

class CheckTrashsDialog extends StatefulWidget {
  const CheckTrashsDialog({super.key});

  @override
  State<CheckTrashsDialog> createState() => _CheckTrashsDialogState();
}

class _CheckTrashsDialogState extends State<CheckTrashsDialog>
    with TickerProviderStateMixin {
  bool _isVisible = true; // 상자를 보여줄지 여부를 결정하는 플래그
  bool _isFinish = false;
  late RescueModel rescueModel;
  late bool isBox;

  AnimationController? _animationController_trashs;
  Animation<double>? _scaleAnimation_trashs;
  AnimationController? _animationController_intersect;
  Animation<double>? _rotateAnimation_intersect;
  AnimationController? _animationController_box;
  Animation<double>? _scaleAnimation_box;

  @override
  void initState() {
    super.initState();
    rescueModel = Provider.of<RescueModel>(context, listen: false);
    isBox = rescueModel.getIsBox();

    _animationController_trashs = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_trashs =
        Tween<double>(begin: 1, end: 10).animate(_animationController_trashs!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _isVisible = false; // 애니메이션 완료 후 상자를 숨깁니다.
              });
            }
          });

    _animationController_intersect = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    _rotateAnimation_intersect = Tween<double>(begin: 1, end: 10)
        .animate(_animationController_intersect!);

    _animationController_box = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box!);

    _animationController_trashs!.forward();
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_intersect!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_box!.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isFinish = !_isFinish;
      });
    });
  }

  @override
  void dispose() {
    _animationController_trashs!.dispose();
    _animationController_intersect!.dispose();
    _animationController_box!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFinish) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            IgnorePointer(
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
                child: Container(
                  child: Center(
                    child: Image.asset(AppIcons.big_intersect),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              child: AnimatedBuilder(
                animation: _animationController_box!,
                builder: (context, widget) {
                  if (_scaleAnimation_box != null) {
                    return Transform.scale(
                      scale: _scaleAnimation_box!.value,
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
                      isBox ? AppIcons.intro_box : AppIcons.trashs,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.2,
              child: _isFinish
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: isBox
                            ? Text('쓰레기 더미 속에서 상자를 발견했어요!',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung90_white))
                            : Text('상자를 발견하지 못했어요 ㅠㅠ',
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.yeonSung90_white)),
                      ),
                    )
                  : Container(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.15,
              child: AnimatedBuilder(
                animation: _animationController_trashs!,
                builder: (context, widget) {
                  if (_scaleAnimation_trashs != null && _isVisible) {
                    return Transform.scale(
                      scale: _scaleAnimation_trashs!.value,
                      child: widget,
                    );
                  } else {
                    return Container(); // 애니메이션 후 위젯을 보여주지 않음
                  }
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
          ],
        ),
      ),
    );
  }
}
