import 'package:flutter/material.dart';

import 'constant/app_colors.dart';
import 'custom/custom_font_weight.dart';
import 'custom/custom_theme.dart';

class CustomThemeData {
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    fontFamily: 'yeonSung',
    textTheme: CustomTheme.textTheme,
    // tabBarTheme: TabBarTheme(
    //   indicator: const UnderlineTabIndicator(
    //     borderSide: BorderSide(color: AppColors.primary, width: 2),
    //   ),
    //   indicatorSize: TabBarIndicatorSize.tab,
    //   labelColor: CustomTheme.colorScheme.primary,
    //   labelStyle: CustomTheme.textTheme.titleSmall.semiBold,
    //   unselectedLabelColor: CustomTheme.colorScheme.contentSecondary,
    //   unselectedLabelStyle: CustomTheme.textTheme.titleSmall,
    //   overlayColor: MaterialStatePropertyAll<Color>(
    //     Colors.grey[300] ?? Colors.grey,
    //   ),
    // ),
  );
}
