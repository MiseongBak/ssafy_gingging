import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class ProfileImage extends StatefulWidget {
  final Image image;
  final bool isPressed;

  const ProfileImage({
    super.key,
    required this.image,
    required this.isPressed,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(width: 3, color: Colors.white),
        boxShadow: widget.isPressed ? [] : [
          BoxShadow(
              color: AppColors.basicgray.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: 1,
              spreadRadius: 1)
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,
      child: ClipRRect(
        // 자식 위젯을 둥글게 클리핑
        borderRadius: BorderRadius.circular(40),
        // 여기서도 컨테이너의 borderRadius와 동일하게 설정
        child: widget.image, // 이곳에 프로필 이미지 위젯을 삽입
      ),
    );
  }
}
