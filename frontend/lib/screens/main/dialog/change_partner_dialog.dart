import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:provider/provider.dart';

class ChangePartnerDialog extends StatefulWidget {
  const ChangePartnerDialog({super.key});

  @override
  State<ChangePartnerDialog> createState() => _ChangePartnerDialogState();
}

class _ChangePartnerDialogState extends State<ChangePartnerDialog> {
  late PetModel petModel;
  late List pets;

  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    petModel = Provider.of<PetModel>(context, listen: false);
    pets = petModel.pets;
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
                    '펫 선택하기',
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
            height: pets.length < 5
                ? MediaQuery.of(context).size.height * 0.08
                : pets.length < 9
                    ? MediaQuery.of(context).size.height * 0.17
                    : MediaQuery.of(context).size.height * 0.255,
            width: pets.length == 1
                ? MediaQuery.of(context).size.width * 0.155
                : pets.length == 2
                    ? MediaQuery.of(context).size.width * 0.33
                    : pets.length == 3
                        ? MediaQuery.of(context).size.width * 0.51
                        : MediaQuery.of(context).size.width * 0.7,
            child: GridView.count(
              crossAxisCount: pets.length == 1
                  ? 1
                  : pets.length == 2
                      ? 2
                      : pets.length == 3
                          ? 3
                          : 4,
              // 한 줄에 4개의 항목 표시
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // padding: EdgeInsets.only(left: 100),
              children: List.generate(pets.length, (index) {
                return Container(
                  height:
                      MediaQuery.of(context).size.height * 0.08, // 각 항목의 높이 설정
                  width:
                      MediaQuery.of(context).size.height * 0.08, // 각 항목의 너비 설정
                  // color: Colors.blue,
                  child: GestureDetector(
                    onTap: () async {
                      final pet = Provider.of<PetModel>(context, listen: false);
                      await pet.getPetDetail(
                          accessToken, pets[index]['member_pet_id']);
                      Navigator.of(context).pop();
                      // Fluttertoast.showToast(msg: '${pets[index]['nickname']}');
                    },
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTapCancel: _onTapCancel,
                    child: ProfileImage(
                      image: pets[index]['active'] == false
                          ? Image.asset(
                              AppIcons.intro_box,
                              width: 50,
                              height: 50,
                            )
                          : Image.network('${pets[index]['image']}'),
                      isPressed: _isPressed,
                    ),
                  ),
                );
              }),
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
