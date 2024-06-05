import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/rescue_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/rescue/dialog/rescue_pet_dialog.dart';
import 'package:provider/provider.dart';

class RescueScreen extends StatefulWidget {
  const RescueScreen({super.key});

  @override
  State<RescueScreen> createState() => _RescueScreenState();
}

class _RescueScreenState extends State<RescueScreen> {
  late RescueModel rescueModel;
  late UserProvider userProvider;
  late String accessToken;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    rescueModel = Provider.of<RescueModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
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
  Widget build(BuildContext context) {
    final currency =
        Provider.of<UserProvider>(context, listen: true).getCurrency();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
          ), // 전체 배경
          child: Stack(
            children: [
              Column(
                children: [
                  const TopBar(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 3, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.basicShadowGray.withOpacity(0.5),
                          offset: const Offset(0, 4),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '구  조',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung90),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '쓰레기 더미 속',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung100),
                        ),
                        Text(
                          '동물들을 구해 주세요!',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung100),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: '구조하기 버튼을 눌러주세요!');
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset(AppIcons.trashs),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!_isButtonDisabled) {
                        setState(() {
                          _isButtonDisabled = true;
                        });
                        rescueModel.rescuePet(accessToken, currency, (result) {
                          if (result == "Success") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const RescuePetDialog();
                              },
                            );
                          } else {
                            // 실패 다이얼로그 처리
                          }
                        });
                        setState(() {
                          _isButtonDisabled = false;
                        });
                      }
                    },
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTapCancel: _onTapCancel,
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.15,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        color: AppColors.rescueButton,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: _isPressed
                            ? []
                            : [
                                BoxShadow(
                                  color: AppColors.basicgray.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                )
                              ],
                      ),
                      child: Center(
                        child: Text(
                          '구조하기',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung90_white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: Image.asset(AppIcons.gging),
                        ),
                        Text(
                          ' X 1000 낑',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung90),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.03,
                child: const CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
