import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class IntroAngryEarth extends StatefulWidget {
  const IntroAngryEarth({super.key});

  @override
  State<IntroAngryEarth> createState() => _IntroEarthState();
}

class _IntroEarthState extends State<IntroAngryEarth>
    with TickerProviderStateMixin {
  AnimationController? _animationController_earth;
  Animation<double>? _scaleAnimation_earth;

  @override
  void initState() {
    super.initState();

    _animationController_earth = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_earth =
        Tween<double>(begin: 0, end: 1).animate(_animationController_earth!);

    _animationController_earth!.forward();
  }

  @override
  void dispose() {
    _animationController_earth!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _scaleAnimation_earth!,
        builder: (context, widget) {
          if (_scaleAnimation_earth != null) {
            return Transform.scale(
              scale: _scaleAnimation_earth!.value,
              child: widget,
            );
          } else {
            return Container();
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Image.asset(AppIcons.earth_1,
                width: MediaQuery.of(context).size.width * 0.8),
          ),
        ),
      ),
    );
  }
}
