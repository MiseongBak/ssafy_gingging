import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class CampaignDetailDialog extends StatefulWidget {
  final String image;

  const CampaignDetailDialog({
    super.key,
    required this.image,
  });

  @override
  State<CampaignDetailDialog> createState() => _CampaignDetailDialogState();
}

class _CampaignDetailDialogState extends State<CampaignDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        // backgroundColor: AppColors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: InteractiveViewer(
            child: Image.network(
              widget.image,
            ),
          ),
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
      ),
    );
  }
}
