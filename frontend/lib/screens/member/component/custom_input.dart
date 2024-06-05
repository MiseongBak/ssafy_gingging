import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final String? hint, label;
  final bool obscure;
  final Icon? icon;
  final IconButton? suffixIcon;
  final AutovalidateMode? autovalidateMode;

  const CustomInput({
    super.key,
    required this.controller,
    this.validator,
    this.keyboard,
    this.icon,
    this.hint,
    this.label,
    this.obscure = false,
    this.suffixIcon,
    this.autovalidateMode,
  });
  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ));
    return Container(
        // width: MediaQuery.of(context).size.width * 0.8,
        width: MediaQuery.of(context).size.width * 0.7,
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          autovalidateMode: autovalidateMode,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style:
              CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
          validator: validator,
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            icon: icon,
            iconColor: AppColors.basicnavy,
            hintText: hint,
            labelText: label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            fillColor: const Color.fromRGBO(225, 235, 200, 1),
            border: outlineInputBorder,
          ),
        ));
  }
}
