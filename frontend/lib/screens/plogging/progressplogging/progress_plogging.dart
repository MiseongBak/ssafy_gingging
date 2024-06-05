import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/plogging/progressplogging/component/progress_map.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_trash_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_lacation_dialog.dart';
import 'package:provider/provider.dart';

class ProgressPlogging extends StatefulWidget {
  // final BluetoothDevice device;
  const ProgressPlogging({
    super.key,
    // required this.device,
  });

  @override
  State<ProgressPlogging> createState() => _ProgressPloggingState();
}

class _ProgressPloggingState extends State<ProgressPlogging> {
  late UserProvider userProvider;
  late bool memberTutorial;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    memberTutorial = userProvider.getMemberTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
        ), // 전체 배경
        child: const Stack(
          children: [
            ProgressMap(),
          ],
        ),
      ),
    ));
  }
}
