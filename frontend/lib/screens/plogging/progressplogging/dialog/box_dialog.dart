import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_box_dialog.dart';

class BoxDialog extends StatefulWidget {
  const BoxDialog({
    super.key,
  });

  @override
  State<BoxDialog> createState() => _BoxDialogState();
}

class _BoxDialogState extends State<BoxDialog> with TickerProviderStateMixin {
  AnimationController? _animationController_box;
  Animation<double>? _scaleAnimation_box;
  AnimationController? _animationController_intersect;
  Animation<double>? _rotateAnimation_intersect;

  @override
  void initState() {
    super.initState();

    _animationController_intersect = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    _rotateAnimation_intersect = Tween<double>(begin: 1, end: 10)
        .animate(_animationController_intersect!);

    _animationController_box = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box!);

    _animationController_intersect!.repeat(reverse: true);
    _animationController_box!.forward();
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController_intersect!.dispose();
    _animationController_box!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
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
                  child: Image.asset(AppIcons.intro_box),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
