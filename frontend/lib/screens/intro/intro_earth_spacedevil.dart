import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class IntroEarthSpacedevil extends StatefulWidget {
  const IntroEarthSpacedevil({super.key});

  @override
  State<IntroEarthSpacedevil> createState() => _IntroEarthSpacedevilState();
}

class _IntroEarthSpacedevilState extends State<IntroEarthSpacedevil>
    with TickerProviderStateMixin {
  AnimationController? _animationController_earth;
  Animation<Offset>? _transAnimation_earth;
  AnimationController? _animationController_spacedevil;
  Animation<Offset>? _transAnimation_spacedevil;

  @override
  void initState() {
    super.initState();

    _animationController_earth = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_earth = Tween<Offset>(
          begin: Offset(screenWidth * -0.7, screenHeight * 0.2),
          end: Offset(screenWidth * -0.3, screenHeight * 0.2))
          .animate(_animationController_earth!);
    });

    _animationController_spacedevil = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_spacedevil = Tween<Offset>(
          begin: Offset(screenWidth * 0.7, screenHeight * -0.15),
          end: Offset(screenWidth * 0.2, screenHeight * -0.15))
          .animate(_animationController_spacedevil!);
    });

    _animationController_earth!.forward();
    _animationController_spacedevil!.forward();
  }

  @override
  void dispose() {
    _animationController_earth!.dispose();
    _animationController_spacedevil!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController_earth!,
          builder: (context, widget) {
            if (_transAnimation_earth != null) {
              return Transform.translate(
                offset: _transAnimation_earth!.value,
                child: widget,
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.earth_5,
                  width: MediaQuery.of(context).size.width * 0.8),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController_spacedevil!,
          builder: (context, widget) {
            if (_transAnimation_spacedevil != null) {
              return Transform.translate(
                offset: _transAnimation_spacedevil!.value,
                child: widget,
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_spacedevil,
                  width: MediaQuery.of(context).size.width * 1),
            ),
          ),
        ),
      ],
    );
  }
}
