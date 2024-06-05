import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/main/partner/partner.dart';
import 'package:frontend/screens/plogging/readyplogging/component/ready_map.dart';
import 'package:frontend/screens/plogging/readyplogging/dialog/bluetooth_connected_dialog.dart';
import 'package:frontend/screens/tutorial/bluetooth_connect_tutorial_dialog.dart';
import 'package:frontend/screens/tutorial/bluetooth_connet_confirm_dialog.dart';
import 'package:frontend/screens/tutorial/confirm_map_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReadyPlogging extends StatefulWidget {
  const ReadyPlogging({super.key});

  @override
  State<ReadyPlogging> createState() => _ReadyPloggingState();
}

class _ReadyPloggingState extends State<ReadyPlogging> {
  late PetModel petModel;
  late UserProvider userProvider;
  late bool tutorial;

  @override
  void initState() {
    super.initState();
    petModel = Provider.of<PetModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    tutorial = userProvider.getTutorial();

    if (tutorial == false) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ConfirmMapDialog();
            },
          ).then((value) {
            setState(() {});
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const BluetoothConnectTutorialDialog();
              },
            ).then((value) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const BluetoothConnectConfirmTutorialDialog();
                },
              ).then((value) {
                userProvider.setTutorial(true);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return BluetoothConnectedDialog(
                        func: goNext,
                        goPrevious: goPrevious,
                        onConfirm: goNoDevice,
                      );
                    });
              });
            });
          });
        },
      );
    }
  }

  goNext() {
    context.push('/ploggingProgress');
  }

  goPrevious() {
    context.push('/main');
  }

  goNoDevice() {
    context.go('/noDevicePlogging');
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
    final pet = Provider.of<PetModel>(context, listen: true).getCurrentPet();
    final currentTutorial =
        Provider.of<UserProvider>(context, listen: true).getMemberTutorial();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
          ), // 전체 배경
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.05,
                child: const ReadyMap(),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: SizedBox(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  // color: Colors.black,
                  child: currentTutorial == true
                      ? Partner(
                          image: pet['active']
                              ? Image.network(
                                  pet['image'],
                                )
                              : Image.asset(
                                  AppIcons.intro_box,
                                ),
                          isPet: pet['active'],
                        )
                      : Container(),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.03,
                child: const CustomBackButton(),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.03,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return BluetoothConnectedDialog(
                            func: goNext,
                            goPrevious: goPrevious,
                            onConfirm: goNoDevice,
                          );
                        });
                  },
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: _onTapCancel,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: AppColors.readyButton,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 3, color: Colors.white),
                      boxShadow: _isPressed
                          ? []
                          : [
                              BoxShadow(
                                color: AppColors.basicgray.withOpacity(0.5),
                                offset: const Offset(0, 4),
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.003,
                          left: MediaQuery.of(context).size.width * 0.015,
                          child: Container(
                            child: const Icon(
                              Icons.directions_run_sharp,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '   시작하기',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung80_white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
