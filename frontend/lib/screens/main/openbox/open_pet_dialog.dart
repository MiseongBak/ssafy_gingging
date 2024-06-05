import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/tutorial/introduce_main_profile_tutorial.dart';
import 'package:provider/provider.dart';

class OpenPetDialog extends StatefulWidget {
  final String image;

  const OpenPetDialog({
    super.key,
    required this.image,
  });

  @override
  State<OpenPetDialog> createState() => _OpenPetDialogState();
}

class _OpenPetDialogState extends State<OpenPetDialog>
    with TickerProviderStateMixin {
  bool _isVisible = true; // 상자를 보여줄지 여부를 결정하는 플래그
  bool _isFinish = false;
  late UserProvider userProvider;
  late String accessToken;
  late bool memberTutorial;
  final TextEditingController _nickNameController = TextEditingController();

  AnimationController? _animationController_box;
  Animation<double>? _scaleAnimation_box;
  AnimationController? _animationController_intersect;
  Animation<double>? _rotateAnimation_intersect;
  AnimationController? _animationController_pet;
  Animation<double>? _scaleAnimation_pet;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    memberTutorial = userProvider.getMemberTutorial();

    _animationController_box = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_box =
        Tween<double>(begin: 1, end: 10).animate(_animationController_box!)
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

    _animationController_pet = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_pet =
        Tween<double>(begin: 0, end: 1).animate(_animationController_pet!);

    _animationController_box!.forward();
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_intersect!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_pet!.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isFinish = !_isFinish;
      });
    });
  }

  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  void dispose() {
    _animationController_box!.dispose();
    _animationController_intersect!.dispose();
    _animationController_pet!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: '닉네임을 입력해주세요');
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
              animation: _animationController_pet!,
              builder: (context, widget) {
                if (_scaleAnimation_pet != null) {
                  return Transform.scale(
                    scale: _scaleAnimation_pet!.value,
                    child: widget,
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.network(
                    '${widget.image}',
                    width: MediaQuery.of(context).size.width * 0.7,
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
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _nickNameController,
                              maxLength: 10,
                              decoration: InputDecoration(
                                counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: '닉네임을 입력해주세요'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final pet =
                                  Provider.of<PetModel>(context, listen: false);
                              String nickName = _nickNameController.text;
                              await pet.updateNickName(
                                  accessToken, -1, nickName);
                              await pet.getPetDetail(accessToken, -1);

                              userProvider.setTutorial(true);

                              Navigator.of(context).pop();
                              if (memberTutorial == false) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return IntroduceMainProfileTutorial();
                                  },
                                );
                              }
                            },
                            onTapDown: _onTapDown,
                            onTapUp: _onTapUp,
                            onTapCancel: _onTapCancel,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: AppColors.rescueButton,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 3, color: Colors.white),
                                boxShadow: _isPressed
                                    ? []
                                    : [
                                        BoxShadow(
                                            color: AppColors.basicShadowGray
                                                .withOpacity(0.5),
                                            offset: const Offset(0, 4),
                                            blurRadius: 1,
                                            spreadRadius: 1)
                                      ],
                              ),
                              child: Center(
                                child: Text(
                                  '입력',
                                  style: CustomFontStyle.getTextStyle(context,
                                      CustomFontStyle.yeonSung90_white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.15,
              child: AnimatedBuilder(
                animation: _animationController_box!,
                builder: (context, widget) {
                  if (_scaleAnimation_box != null && _isVisible) {
                    return Transform.scale(
                      scale: _scaleAnimation_box!.value,
                      child: widget,
                    );
                  } else {
                    return Container(); // 애니메이션 후 위젯을 보여주지 않음
                  }
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
          ],
        ),
      ),
    );
  }
}
