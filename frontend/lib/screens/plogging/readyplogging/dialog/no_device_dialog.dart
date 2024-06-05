import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class NoDeviceDialog extends StatelessWidget {
  final Function onConfirm;
  const NoDeviceDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '기기를 사용하지 않는 플로깅입니다',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung70),
          ),
          Text(
            '일부 기능은 지원하지 않습니다.',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung70),
          ),
          Text(
            '정말 진행하시겠습니까?',
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung70),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  child: const Text('확인'))
            ],
          ),
        ],
      ),
    );
  }
}
