// lib/main.dart
import 'package:flutter/material.dart';
import 'package:formify/config/theme/app_theme.dart';
import 'package:formify/constants/export.dart';
import 'package:formify/config/theme/theme-cont.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.themeMode,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        initialRoute: AppLinks.splash_screen,
        getPages: AppRoutes.pages,
      );
    });
  }
}