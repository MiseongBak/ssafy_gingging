import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class IntroAnimalBox extends StatefulWidget {
  const IntroAnimalBox({
    super.key,
  });

  @override
  State<IntroAnimalBox> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroAnimalBox>
    with TickerProviderStateMixin {
  AnimationController? _animationController_animal_1;
  Animation<double>? _scaleAnimation_animal_1;
  AnimationController? _animationController_animal_2;
  Animation<double>? _scaleAnimation_animal_2;
  AnimationController? _animationController_animal_3;
  Animation<double>? _scaleAnimation_animal_3;
  AnimationController? _animationController_animal_4;
  Animation<double>? _scaleAnimation_animal_4;
  AnimationController? _animationController_animal_5;
  Animation<double>? _scaleAnimation_animal_5;
  AnimationController? _animationController_box_1;
  Animation<double>? _scaleAnimation_box_1;
  AnimationController? _animationController_box_2;
  Animation<double>? _scaleAnimation_box_2;
  AnimationController? _animationController_box_3;
  Animation<double>? _scaleAnimation_box_3;
  AnimationController? _animationController_box_4;
  Animation<double>? _scaleAnimation_box_4;
  AnimationController? _animationController_box_5;
  Animation<double>? _scaleAnimation_box_5;

  @override
  void initState() {
    super.initState();

    _animationController_animal_1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_animal_1 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_animal_1!);

    _animationController_animal_2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_animal_2 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_animal_2!);

    _animationController_animal_3 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_animal_3 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_animal_3!);

    _animationController_animal_4 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_animal_4 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_animal_4!);

    _animationController_animal_5 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_animal_5 =
        Tween<double>(begin: 1, end: 0).animate(_animationController_animal_5!);

    _animationController_box_1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box_1 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box_1!);

    _animationController_box_2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box_2 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box_2!);

    _animationController_box_3 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box_3 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box_3!);

    _animationController_box_4 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box_4 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box_4!);

    _animationController_box_5 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box_5 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_box_5!);

    _animationController_animal_1!.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController_animal_2!.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _animationController_animal_3!.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _animationController_animal_4!.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _animationController_animal_5!.forward();
    });
    _animationController_box_1!.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController_box_2!.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _animationController_box_3!.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _animationController_box_4!.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _animationController_box_5!.forward();
    });
  }

  @override
  void dispose() {
    _animationController_animal_1!.dispose();
    _animationController_animal_2!.dispose();
    _animationController_animal_3!.dispose();
    _animationController_animal_4!.dispose();
    _animationController_animal_5!.dispose();
    _animationController_box_1!.dispose();
    _animationController_box_2!.dispose();
    _animationController_box_3!.dispose();
    _animationController_box_4!.dispose();
    _animationController_box_5!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.18,
            right: MediaQuery.of(context).size.width * 0.03,
            child: AnimatedBuilder(
              animation: _scaleAnimation_animal_1!,
              builder: (context, widget) {
                if (_scaleAnimation_animal_1 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_animal_1!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_animal_1,
                      width: MediaQuery.of(context).size.width * 0.4),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: MediaQuery.of(context).size.width * 0.03,
            child: AnimatedBuilder(
              animation: _scaleAnimation_animal_2!,
              builder: (context, widget) {
                if (_scaleAnimation_animal_2 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_animal_2!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_animal_2,
                      width: MediaQuery.of(context).size.width * 0.3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            right: MediaQuery.of(context).size.width * 0.25,
            child: AnimatedBuilder(
              animation: _scaleAnimation_animal_3!,
              builder: (context, widget) {
                if (_scaleAnimation_animal_3 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_animal_3!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_animal_3,
                      width: MediaQuery.of(context).size.width * 0.3),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.07,
            child: AnimatedBuilder(
              animation: _scaleAnimation_animal_4!,
              builder: (context, widget) {
                if (_scaleAnimation_animal_4 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_animal_4!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_animal_4,
                      width: MediaQuery.of(context).size.width * 0.2),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.1,
            child: AnimatedBuilder(
              animation: _scaleAnimation_animal_5!,
              builder: (context, widget) {
                if (_scaleAnimation_animal_5 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_animal_5!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_animal_5,
                      width: MediaQuery.of(context).size.width * 0.4),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.18,
            right: MediaQuery.of(context).size.width * 0.03,
            child: AnimatedBuilder(
              animation: _scaleAnimation_box_1!,
              builder: (context, widget) {
                if (_scaleAnimation_box_1 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_box_1!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_box,
                      width: MediaQuery.of(context).size.width * 0.4),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: MediaQuery.of(context).size.width * 0.105,
            child: AnimatedBuilder(
              animation: _scaleAnimation_box_2!,
              builder: (context, widget) {
                if (_scaleAnimation_box_2 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_box_2!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_box,
                      width: MediaQuery.of(context).size.width * 0.2),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            right: MediaQuery.of(context).size.width * 0.27,
            child: AnimatedBuilder(
              animation: _scaleAnimation_box_3!,
              builder: (context, widget) {
                if (_scaleAnimation_box_3 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_box_3!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_box,
                      width: MediaQuery.of(context).size.width * 0.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.07,
            child: AnimatedBuilder(
              animation: _scaleAnimation_box_4!,
              builder: (context, widget) {
                if (_scaleAnimation_box_4 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_box_4!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_box,
                      width: MediaQuery.of(context).size.width * 0.15),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.2,
            child: AnimatedBuilder(
              animation: _scaleAnimation_box_5!,
              builder: (context, widget) {
                if (_scaleAnimation_box_5 != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_box_5!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.intro_box,
                      width: MediaQuery.of(context).size.width * 0.25),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
