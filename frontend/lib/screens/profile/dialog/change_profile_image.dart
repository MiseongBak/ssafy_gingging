import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ChangeProfileImage extends StatefulWidget {
  final String name;
  final int index;

  const ChangeProfileImage({
    super.key,
    required this.name,
    required this.index,
  });

  @override
  State<ChangeProfileImage> createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
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
                  color: AppColors.basicgreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '프로필 사진 변경',
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
                    color: AppColors.basicgreen,
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
          Text(
            '${widget.name} (으)로 변경 하시겠습니까?',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung80),
          )
        ],
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () async {
            final member = Provider.of<MemberModel>(context, listen: false);
            await member.updateProfileImage(accessToken, widget.index);
            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.height * 0.04,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.basicgreen),
            child: Center(
              child: Text(
                "확인",
                style: CustomFontStyle.getTextStyle(
                  context,
                  CustomFontStyle.yeonSung70_white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
