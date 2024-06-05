import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class IntroDialogWarning extends StatefulWidget {
  const IntroDialogWarning({super.key});

  @override
  State<IntroDialogWarning> createState() => _dialogState();
}

class _dialogState extends State<IntroDialogWarning> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 자치 안하게
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '경고',
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
                  child: Icon(
                    Icons.circle_notifications_rounded,
                    size: 35,
                    color: AppColors.error,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            child: Text(
              '지구가 도움을',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung90),
            ),
          ),
          Container(
            child: Text(
              '요청하고 있습니다.',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung90),
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
