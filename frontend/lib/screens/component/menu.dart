import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final Color color;
  final Color shadowColor;
  final Icon icon;
  final String content;
  final bool isPressed;

  const Menu({
    super.key,
    required this.color,
    required this.shadowColor,
    required this.icon,
    required this.content,
    required this.isPressed,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: widget.isPressed ? widget.color : widget.shadowColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: Colors.white),
            boxShadow: widget.isPressed ? [] : [
              BoxShadow(
                color: AppColors.basicgray.withOpacity(0.5),
                offset: Offset(0, 4),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.003,
          left: MediaQuery.of(context).size.width * 0.007,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width * 0.136,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(16.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.height * 0.04,
                  child: widget.icon,
                ),
                Text(
                  widget.content,
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung50_white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
