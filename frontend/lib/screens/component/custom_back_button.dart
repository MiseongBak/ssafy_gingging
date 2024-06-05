import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({super.key});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  late MainProvider mainProvider;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
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
    return GestureDetector(
      onTap: () {
        if (mainProvider.isMenuSelected == 'rescue') {
          mainProvider.menuSelected('profile');
        } else if (mainProvider.isMenuSelected == 'profile') {
          mainProvider.menuSelected('main');
        }

        context.pop();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.rescueButton,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 3, color: Colors.white),
          boxShadow: _isPressed ? [] : [
            BoxShadow(
              color: AppColors.basicgray.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          FontAwesomeIcons.arrowLeft,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
