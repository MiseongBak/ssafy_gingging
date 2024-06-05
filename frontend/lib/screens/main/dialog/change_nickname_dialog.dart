import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ChangeNickNameDialog extends StatefulWidget {
  const ChangeNickNameDialog({super.key});

  @override
  State<ChangeNickNameDialog> createState() => _ChangeNickNameDialogState();
}

class _ChangeNickNameDialogState extends State<ChangeNickNameDialog> {
  final TextEditingController _nickNameController = TextEditingController();
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
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
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 자치 안하게
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  color: AppColors.basicgray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '펫 닉네임 변경',
                    style: CustomFontStyle.getTextStyle(
                      context,
                      CustomFontStyle.yeonSung80_white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEBF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.basicgray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.circleXmark,
                      size: 41,
                      color: Color(0xFFEEEBF5),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.55,
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: '닉네임을 입력해주세요'),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final pet = Provider.of<PetModel>(context, listen: false);
                    String nickName = _nickNameController.text;
                    if (nickName == "") {
                      Fluttertoast.showToast(msg: '닉네임을 입력해주세요!');
                    } else {
                      await pet.updateNickName(accessToken, -1, nickName);
                      await pet.getPetDetail(accessToken, -1);
                      Navigator.of(context).pop();
                    }
                  },
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: _onTapCancel,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.13,
                    decoration: BoxDecoration(
                      color: AppColors.rescueButton,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 3, color: Colors.white),
                      boxShadow: _isPressed ? [] : [
                        BoxShadow(
                            color: AppColors.basicShadowGray.withOpacity(0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '입력',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung70_white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // actions: <Widget>[
      //   GreenButton(
      //     "취소",
      //     onPressed: () => Navigator.of(context).pop(), // 모달 닫기
      //   ),
      //   RedButton(
      //     "종료",
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //       onConfirm();
      //     },
      //   ),
      // ],
    );
  }
}
