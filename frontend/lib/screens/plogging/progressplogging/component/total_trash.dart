import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/provider/plogging_provider.dart';
import 'package:provider/provider.dart';

class TotalTrash extends StatefulWidget {
  const TotalTrash({
    super.key,
  });

  @override
  State<TotalTrash> createState() => _TotalTrashState();
}

class _TotalTrashState extends State<TotalTrash> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> trashs =
        Provider.of<PloggingProvider>(context, listen: true).getTrashs();

    return trashs.isNotEmpty
        ? Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.basicgray.withOpacity(0.2),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  children: [
                    Text(
                      '원정 집계 현황',
                      style: CustomFontStyle.getTextStyle(
                        context,
                        CustomFontStyle.yeonSung70,
                      ),
                    ),
                    Row(children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            AppIcons.plamong,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            '플라몽 처치 : ${trashs['plastic']}',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung70,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            AppIcons.pocanmong,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            '포캔몽 처치 : ${trashs['can']}',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung70,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            AppIcons.yulmong,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            '율몽 처치 : ${trashs['glass']}',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung70,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            AppIcons.mizzomon,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            '미쪼몬 처치 : ${trashs['normal']}',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung70,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          trashs['isExp']
                              ? const Text('EXP')
                              : Image.asset(
                                  AppIcons.gging,
                                  width: 25,
                                  height: 25,
                                ),
                          Text(
                            ': ${trashs['value']}',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung70,
                            ),
                          ),
                          Image.asset(
                            AppIcons.intro_box,
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            ': ${trashs['box']}',
                            style: CustomFontStyle.getTextStyle(
                              context,
                              CustomFontStyle.yeonSung70,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ],
          )
        : const CircularProgressIndicator();
  }
}
