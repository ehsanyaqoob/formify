import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:formify/config/theme/theme-cont.dart';

class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      return IconButton(
        icon: Icon(
          themeController.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: themeController.isDarkMode ? Colors.yellow : Colors.black,
          size: 26,
        ),
        onPressed: () {
          themeController.toggleTheme();
        },
      );
    });
  }
}
