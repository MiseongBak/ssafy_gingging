import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:provider/provider.dart';

class RankingList extends StatefulWidget {
  final int rank;
  final String nickName;
  final int score;
  final int profile;

  const RankingList({
    super.key,
    required this.rank,
    required this.nickName,
    required this.score,
    required this.profile,
  });

  @override
  State<RankingList> createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  @override
  Widget build(BuildContext context) {
    final allPets = Provider.of<PetModel>(context, listen: true).getAllPet();

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.125,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(color: Colors.black),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * 0.015,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.07,
              // color: Colors.red,
              child: Center(
                child: Text(
                  '${widget.rank}',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung80),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.18,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.105,
              width: 45,
              child: ProfileImage(
                image: widget.profile == 0
                    ? Image.asset(AppIcons.earth_3)
                    : Image.network('${allPets[widget.profile - 1]['image']}'),
                isPressed: false,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.31,
            child: Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                '${widget.nickName}',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung80),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.005,
            child: Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                '${widget.score} exp',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
