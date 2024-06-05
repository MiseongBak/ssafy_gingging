import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class IntroDialogHelping extends StatefulWidget {
  const IntroDialogHelping({super.key});

  @override
  State<IntroDialogHelping> createState() => _dialogState();
}

class _dialogState extends State<IntroDialogHelping> {
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
                margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  color: AppColors.help,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '도움',
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
                    color: const Color(0xFFEEEBF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const Positioned(
                right: 0,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 35,
                    color: AppColors.help,
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
              '상자속에 갇혀버린 동료들을',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung90),
            ),
          ),
          Container(
            child: Text(
              '찾아 떠나볼까요?',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung90),
            ),
          ),
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
