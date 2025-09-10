// lib/constants/app_themes.dart
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: kBlack,
  fontFamily: AppFonts.Figtree,
  splashColor: kDynamicPrimary.withOpacity(0.10),
  highlightColor: kDynamicPrimary.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
    primary: kDynamicPrimary,
    secondary: kGreyColor.withOpacity(0.1),
    tertiary: kBlack,
    onPrimary: kWhite,
    onSecondary: kWhite,
  ),
  useMaterial3: false,
  textSelectionTheme: TextSelectionThemeData(cursorColor: kWhite),
  appBarTheme: AppBarTheme(
    backgroundColor: kBlack,
    foregroundColor: kWhite,
    elevation: 0,
  ),
);

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kWhite,
  fontFamily: AppFonts.Figtree,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: kDynamicPrimary,
    foregroundColor: kBlack,
  ),
  splashColor: kDynamicPrimary.withOpacity(0.10),
  highlightColor: kDynamicPrimary.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
    primary: kDynamicPrimary,
    secondary: kGreyColor.withOpacity(0.1),
    tertiary: kWhite,
    onPrimary: kBlack,
    onSecondary: kBlack,
  ),
  useMaterial3: false,
  textSelectionTheme: TextSelectionThemeData(cursorColor: kBlack),
);
