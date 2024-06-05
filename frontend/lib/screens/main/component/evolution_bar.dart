import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/main/openbox/open_box_dialog.dart';
import 'package:provider/provider.dart';

class EvolutionBar extends StatefulWidget {
  const EvolutionBar({super.key});

  @override
  State<EvolutionBar> createState() => _EvolutionBarState();
}

class _EvolutionBarState extends State<EvolutionBar> {
  late PetModel petModel;
  late UserProvider userProvider;
  late String accessToken;
  late Map currentPet;

  @override
  void initState() {
    super.initState();

    petModel = Provider.of<PetModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    petModel.getPetDetail(accessToken, -1);
    currentPet = petModel.getCurrentPet();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            petModel.openBox(accessToken, -1);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return OpenBoxDialog(
                  image: currentPet['image'],
                );
              },
            ).then(
              (value) => setState(() {}),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: Colors.white),
              boxShadow: [
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
                '상자를 열어보세요!',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung80_white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
