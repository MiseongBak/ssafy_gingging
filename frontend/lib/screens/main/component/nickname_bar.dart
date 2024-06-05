import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/main/dialog/change_nickname_dialog.dart';

class NickNameBar extends StatefulWidget {
  final String nickName;

  const NickNameBar({
    super.key,
    required this.nickName,
  });

  @override
  State<NickNameBar> createState() => _NickNameBarState();
}

class _NickNameBarState extends State<NickNameBar> {
  bool _isNicknamePressed = false;

  void _onNicknameTapDown(TapDownDetails details) {
    setState(() {
      _isNicknamePressed = true;
    });
  }

  void _onNicknameTapUp(TapUpDetails details) {
    setState(() {
      _isNicknamePressed = false;
    });
  }

  void _onNicknameTapCancel() {
    setState(() {
      _isNicknamePressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ChangeNickNameDialog();
          },
        );
      },
      onTapDown: _onNicknameTapDown,
      onTapUp: _onNicknameTapUp,
      onTapCancel: _onNicknameTapCancel,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 3, color: Colors.white),
          boxShadow: _isNicknamePressed ? [] : [
            BoxShadow(
              color: AppColors.basicgray.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        child: Center(
            child: Text(
          '${widget.nickName}',
          style: CustomFontStyle.getTextStyle(
              context, CustomFontStyle.yeonSung80),
        )),
      ),
    );
  }
}
