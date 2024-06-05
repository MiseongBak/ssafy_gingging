import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class IntroTrash extends StatefulWidget {
  const IntroTrash({super.key});

  @override
  State<IntroTrash> createState() => _IntroEarthSpacedevilState();
}

class _IntroEarthSpacedevilState extends State<IntroTrash>
    with TickerProviderStateMixin {
  AnimationController? _animationController_trash_1;
  Animation<double>? _rotateAnimation_trash_1;
  Animation<double>? _scaleAnimation_trash_1;
  Animation<Offset>? _transAnimation_trash_1;
  AnimationController? _animationController_trash_2;
  Animation<double>? _rotateAnimation_trash_2;
  Animation<double>? _scaleAnimation_trash_2;
  Animation<Offset>? _transAnimation_trash_2;
  AnimationController? _animationController_trash_3;
  Animation<double>? _rotateAnimation_trash_3;
  Animation<double>? _scaleAnimation_trash_3;
  Animation<Offset>? _transAnimation_trash_3;
  AnimationController? _animationController_trash_4;
  Animation<double>? _rotateAnimation_trash_4;
  Animation<double>? _scaleAnimation_trash_4;
  Animation<Offset>? _transAnimation_trash_4;
  AnimationController? _animationController_trash_5;
  Animation<double>? _rotateAnimation_trash_5;
  Animation<double>? _scaleAnimation_trash_5;
  Animation<Offset>? _transAnimation_trash_5;

  bool CryingEarthCheck = false;

  @override
  void initState() {
    super.initState();

    _animationController_trash_1 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _rotateAnimation_trash_1 =
        Tween<double>(begin: 0, end: 10).animate(_animationController_trash_1!);
    _scaleAnimation_trash_1 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_trash_1!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_trash_1 = Tween<Offset>(
              begin: Offset(screenWidth * 0.1, screenHeight * -0.2),
              end: Offset(screenWidth * -0.4, screenHeight * 0.2))
          .animate(_animationController_trash_1!);
    });

    _animationController_trash_2 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _rotateAnimation_trash_2 =
        Tween<double>(begin: 0, end: 10).animate(_animationController_trash_2!);
    _scaleAnimation_trash_2 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_trash_2!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_trash_2 = Tween<Offset>(
              begin: Offset(screenWidth * 0.2, screenHeight * -0.1),
              end: Offset(screenWidth * -0.4, screenHeight * 0.2))
          .animate(_animationController_trash_2!);
    });

    _animationController_trash_3 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _rotateAnimation_trash_3 =
        Tween<double>(begin: 0, end: 10).animate(_animationController_trash_3!);
    _scaleAnimation_trash_3 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_trash_3!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_trash_3 = Tween<Offset>(
              begin: Offset(screenWidth * 0, screenHeight * -0.1),
              end: Offset(screenWidth * -0.4, screenHeight * 0.2))
          .animate(_animationController_trash_3!);
    });

    _animationController_trash_4 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _rotateAnimation_trash_4 =
        Tween<double>(begin: 0, end: 10).animate(_animationController_trash_4!);
    _scaleAnimation_trash_4 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_trash_4!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_trash_4 = Tween<Offset>(
              begin: Offset(screenWidth * 0.15, screenHeight * 0),
              end: Offset(screenWidth * -0.4, screenHeight * 0.2))
          .animate(_animationController_trash_4!);
    });

    _animationController_trash_5 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _rotateAnimation_trash_5 =
        Tween<double>(begin: 0, end: 10).animate(_animationController_trash_5!);
    _scaleAnimation_trash_5 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_trash_5!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_trash_5 = Tween<Offset>(
              begin: Offset(screenWidth * -0.1, screenHeight * 0),
              end: Offset(screenWidth * -0.4, screenHeight * 0.2))
          .animate(_animationController_trash_5!);
    });

    _animationController_trash_1!.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController_trash_2!.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _animationController_trash_3!.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _animationController_trash_4!.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _animationController_trash_5!.forward();
    });
    Future.delayed(const Duration(milliseconds: 2300), () {
      setState(() {
        CryingEarthCheck = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController_trash_1!.dispose();
    _animationController_trash_2!.dispose();
    _animationController_trash_3!.dispose();
    _animationController_trash_4!.dispose();
    _animationController_trash_5!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: CryingEarthCheck ? MediaQuery.of(context).size.width * -0.23 : MediaQuery.of(context).size.width * -0.2,
          bottom: MediaQuery.of(context).size.height * 0.06,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(CryingEarthCheck ? AppIcons.earth_4 : AppIcons.earth_5,
                  width: MediaQuery.of(context).size.width * 0.8),
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * -0.2,
          top: MediaQuery.of(context).size.height * -0.095,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_spacedevil,
                  width: MediaQuery.of(context).size.width * 1),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController_trash_1!,
          builder: (context, widget) {
            if (_transAnimation_trash_1 != null) {
              return Transform.translate(
                offset: _transAnimation_trash_1!.value,
                child: Transform.rotate(
                  angle: _rotateAnimation_trash_1!.value,
                  child: Transform.scale(
                    scale: _scaleAnimation_trash_1!.value,
                    child: widget,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_trash_1,
                  width: MediaQuery.of(context).size.width * 0.3),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController_trash_2!,
          builder: (context, widget) {
            if (_transAnimation_trash_2 != null) {
              return Transform.translate(
                offset: _transAnimation_trash_2!.value,
                child: Transform.rotate(
                  angle: _rotateAnimation_trash_2!.value,
                  child: Transform.scale(
                    scale: _scaleAnimation_trash_2!.value,
                    child: widget,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_trash_2,
                  width: MediaQuery.of(context).size.width * 0.14),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController_trash_3!,
          builder: (context, widget) {
            if (_transAnimation_trash_3 != null) {
              return Transform.translate(
                offset: _transAnimation_trash_3!.value,
                child: Transform.rotate(
                  angle: _rotateAnimation_trash_3!.value,
                  child: Transform.scale(
                    scale: _scaleAnimation_trash_3!.value,
                    child: widget,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_trash_3,
                  width: MediaQuery.of(context).size.width * 0.25),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController_trash_4!,
          builder: (context, widget) {
            if (_transAnimation_trash_4 != null) {
              return Transform.translate(
                offset: _transAnimation_trash_4!.value,
                child: Transform.rotate(
                  angle: _rotateAnimation_trash_4!.value,
                  child: Transform.scale(
                    scale: _scaleAnimation_trash_4!.value,
                    child: widget,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_trash_4,
                  width: MediaQuery.of(context).size.width * 0.2),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController_trash_5!,
          builder: (context, widget) {
            if (_transAnimation_trash_5 != null) {
              return Transform.translate(
                offset: _transAnimation_trash_5!.value,
                child: Transform.rotate(
                  angle: _rotateAnimation_trash_5!.value,
                  child: Transform.scale(
                    scale: _scaleAnimation_trash_5!.value,
                    child: widget,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(AppIcons.intro_trash_5,
                  width: MediaQuery.of(context).size.width * 0.14),
            ),
          ),
        ),
      ],
    );
  }
}
