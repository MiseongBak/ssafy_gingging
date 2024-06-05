import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/component/topbar/setting.dart';
import 'package:frontend/screens/component/topbar/gging_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late MainProvider mainProvider;
  late UserProvider userProvider;
  late String accessToken;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
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
    var currentProfileImage =
        Provider.of<UserProvider>(context, listen: true).getProfileImage();
    final allPets = Provider.of<PetModel>(context, listen: true).getAllPet();

    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              if (!_isButtonDisabled) {
                setState(() {
                  _isButtonDisabled = true; // 버튼 비활성화
                });
                if (mainProvider.isMenuSelected != 'profile') {
                  final pet = Provider.of<PetModel>(context, listen: false);
                  final member =
                      Provider.of<MemberModel>(context, listen: false);
                  await pet.getAllPets(accessToken);
                  await member.getMemberInfo(accessToken);
                  context.push('/profile').then(
                        (value) => setState(() {
                          _isButtonDisabled = false;
                        }),
                      );
                }
                selectedMenu('profile');
              }
            },
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: ProfileImage(
              image: currentProfileImage == 0
                  ? Image.asset(AppIcons.earth_3)
                  : Image.network(
                      '${allPets[currentProfileImage - 1]['image']}'),
              isPressed : _isPressed,
            ),
          ),
          const GgingBar(),
          const Setting(),
        ],
      ),
    );
  }
}
