import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster_content.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster_title.dart';

class ClearMonster extends StatefulWidget {
  final Map pet;

  const ClearMonster({
    super.key,
    required this.pet,
  });

  @override
  State<ClearMonster> createState() => _ClearMonsterState();
}

class _ClearMonsterState extends State<ClearMonster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: Offset(0, 4),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClearMonsterTitle(
            petNickname: widget.pet['nickname'],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClearMonsterContent(
                monster: Image.asset(AppIcons.plamong),
                color: AppColors.basicgreen,
                content: '플라몽',
                count: widget.pet['plastic'],
              ),
              ClearMonsterContent(
                monster: Image.asset(AppIcons.pocanmong),
                color: AppColors.basicgray,
                content: '포 캔몽',
                count: widget.pet['can'],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClearMonsterContent(
                monster: Image.asset(AppIcons.yulmong),
                color: AppColors.basicpink,
                content: '율몽',
                count: widget.pet['glass'],
              ),
              ClearMonsterContent(
                monster: Image.asset(AppIcons.mizzomon),
                color: AppColors.basicnavy,
                content: '미쪼몬',
                count: widget.pet['normal'],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
