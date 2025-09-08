// lib/constants/app_colors.dart
import 'package:flutter/material.dart';
import 'package:formify/config/theme/theme-cont.dart';
import 'package:get/get.dart';

// Get the theme controller instance
ThemeController get _themeController => Get.find<ThemeController>();

// Dynamic colors that change with theme
Color get kDynamicBackground => _themeController.isDarkMode ? kBlack : kWhite;
Color get kDynamicText => _themeController.isDarkMode ? kWhite : kBlack;
Color get kDynamicPrimary => _themeController.isDarkMode ? kPrimaryColorDark : kPrimaryColor;
Color get kDynamicSecondary => _themeController.isDarkMode ? kSecondaryColorDark : kSecondaryColor;

// Blue Ocean theme colors
const kPrimaryColor = Color(0xFF0077B6);      // Deep ocean blue
const kPrimaryColor2 = Color(0xFF00B4D8);     // Bright ocean blue
const kPrimaryColor3 = Color(0xFF90E0EF);     // Light ocean blue
final kPrimaryColor4 = Color(0x800077B6);     // Semi-transparent deep blue

const kSecondaryColor = Color(0xFFFFFFFF);    // Pure white
const kSecondaryColor2 = Color(0xFFF8F9FA);   // Very light grey
const kSecondaryColor3 = Color(0xFFE9ECEF);   // Light grey
final kSecondaryColor4 = Color(0x80FFFFFF);   // Semi-transparent white

// Dark theme variants
const kPrimaryColorDark = Color(0xFF005A87);      // Darker ocean blue
const kPrimaryColor2Dark = Color(0xFF0086B3);     // Medium ocean blue
const kPrimaryColor3Dark = Color(0xFF66C7E0);     // Light ocean blue

const kSecondaryColorDark = Color(0xFF121212);    // Near black
const kSecondaryColor2Dark = Color(0xFF2D2D2D);   // Dark grey
const kSecondaryColor3Dark = Color(0xFF454545);   // Medium dark grey

// Common colors (remain the same for both themes)
const kTransperentColor = Colors.transparent;
const kWhite = Color(0xFFFFFFFF);
const kWhite2 = Color(0xFFAAAAAA);
const kBlack = Color(0xFF000000);

const kAccentColor = Color(0xFF0E0E0E);
const kAccentColor2 = Color(0xFF4E4E4E);
const kAccentColor3 = Color(0xFF8E8E8E);
final kAccentColor4 = Color(0x800E0E0E);

final kOverLay = Color(0x80000000); 
final KSectionBg = Color(0xFF2F2F2F); 

const kbackground = Color(0xFFF9FAFB);
const kSubText = Color(0xFF848E99);

//! All Text Colors
const kSubText2 = Color(0xFF53555B);
const kSubText3 = Color(0xFF8A938E);
const kSubText4 = Color(0xFF89938D);
const kBlackText = Color(0xFF000000);
const kTextWhite = Color(0xFFFFFFFF);
const kPurpleText = Color(0xFF49243E);

//! All Solids
const kPurple2 = Color(0xFFA66FB5);
const kPurple = Color(0xFFAE0AC9);
const kredColor = Color.fromARGB(255, 255, 0, 0);
const kredColorLight = Color(0x5BFECDCA);
const kOrangeColor = Color(0xFFFF7F0E);
const kYellowColor = Color(0xFFF5BD4F);
const kYellowColorLight = Color(0x7FFEF0C7);
const kgreenColor = Color(0xFF2CA02C);
const kgreenColorLight = Color(0x2634C759);
const kBlue = Color(0xFF3285CD);
const kCyran = Color(0xFF6AE9E9);
const kPink = Color(0xFFBA2387);

//!All Greys
const kGreyColor = Color(0xff767676);
const kGreyColor2 = Color(0xffd8dadc);
const kGreyColor3 = Color(0xffBABBBE);
const kGreyColor4 = Color(0xff8D8D8D);
const kGreyColor5 = Color(0xffA1A1A1);
const kGreyColor6 = Color(0xFFEAEAEA);
const kGreylightColor = Color(0xffe3e3e3);
const klightGrey2 = Color(0x1F787878);
const kLinearProgressbgGreyColor = Color(0xFFE9E9E9);

//!All  blacks
const kBlacklightColor = Color(0xff222222);
const klightblackColor = Color(0x80000000);
const kBlackBg = Color(0xff222222);
const kBlack300 = Color(0xFF151515);
const kBlack200 = Color(0xFF333333);
const kBlack150 = Color(0xFF666666);
const kBlack100 = Color(0xFF9D9D9D);
const kBlack50 = Color(0xFFD5D5D5);
const kBlack25 = Color(0xFFF8F8F8);

//! All background Colors
const kbackgroundSplash = Color(0xFF06021D);
const kbackgroundpinput = Color(0xFFE9E8E8);
const kbackgroundContainer = Color(0xFFE6E7EA);
const kGreyContainerColor = Color(0xFFEBEBEB);
const kGreyContainerGreyColor = Color(0xFFE0E0E0);
const kGreyContainerGreyColor2 = Color(0xFFF5F5F5);
const kbackgroundBlueContainer = Color(0xFFEAF5FF);
const kbackgroundBlue2Container = Color(0xFF0B59A7);
const kGreyContainerGreenColor = Color(0x1908AD69);
const kContainerCyranColor = Color(0xFFE3FCFC);
const kContainerRedColor = Color(0xFFB70F0F);
const kContainerRedColor2 = Color(0xFFFEEEEE);
const kContainerYellowColor = Color(0xFFF5BD4F);
const kContainerYellowColor2 = Color(0xFFFCF6D4);

//! All feilds Colors
const kFeild = Color(0xFF1B1B1B);
const kStroke = Color(0xFF313131);

//! All Borders and Dividers Colors
const kDividerColor = Color(0xFFE7E7E7);
const kDividerColor2 = Color(0xFFA4A4A6);
const kBorderColor = Color(0xFFE6E6E6);
const kBorderColor2 = Color(0xFFF6F6F6);
const kBorderColor3 = Color(0xFFC2C2C2);
const kGreyDividerColor = Color(0x33000000);
const kGreyborder = Color(0xffBCBCBC);
const kGreyborder2 = Color(0xffD0D5DD);
const kGreyborder3 = Color(0xffB7B7B7);

//! All Gradients
final kContainerBackgroundGradeintColor = LinearGradient(
  colors: [kDynamicPrimary, kAccentColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);