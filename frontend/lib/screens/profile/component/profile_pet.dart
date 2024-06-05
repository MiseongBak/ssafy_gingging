import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePet extends StatefulWidget {
  // final int profilePetImage;

  const ProfilePet({
    super.key,
    // required this.profilePetImage,
  });

  @override
  State<ProfilePet> createState() => _ProfilePetState();
}

class _ProfilePetState extends State<ProfilePet> {
  @override
  Widget build(BuildContext context) {
    var currentProfileImage =
        Provider.of<UserProvider>(context, listen: true).getProfileImage();
    final allPets = Provider.of<PetModel>(context, listen: true).getAllPet();

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      // decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: currentProfileImage == 0
            ? Image.asset(AppIcons.earth_3)
            : Image.network('${allPets[currentProfileImage - 1]['image']}'),
      ),
    );
  }
}
