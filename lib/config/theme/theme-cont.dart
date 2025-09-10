// lib/controllers/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  final Rx<ThemeMode> _themeMode = ThemeMode.dark.obs;
  final RxBool _isDarkMode = true.obs;
  Rx<ThemeMode> get theme => _themeMode;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _loadThemePreference();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangePlatformBrightness() {
    // This gets called automatically when system theme changes
    if (_themeMode.value == ThemeMode.system) {
      _checkSystemTheme();
      update(); // Notify listeners about the change
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check system theme when app resumes
      if (_themeMode.value == ThemeMode.system) {
        _checkSystemTheme();
        update();
      }
    }
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String theme = prefs.getString('theme') ?? 'dark'; // Default dark

      switch (theme) {
        case 'light':
          _themeMode.value = ThemeMode.light;
          _isDarkMode.value = false;
          break;
        case 'dark':
          _themeMode.value = ThemeMode.dark;
          _isDarkMode.value = true;
          break;
        case 'system':
          _themeMode.value = ThemeMode.system;
          _checkSystemTheme();
          break;
        default:
          _themeMode.value = ThemeMode.dark; // Fallback to dark
          _isDarkMode.value = true;
      }
    } catch (e) {
      // Fallback to dark theme if loading fails
      _themeMode.value = ThemeMode.dark;
      _isDarkMode.value = true;
    }
  }

  void _checkSystemTheme() {
    final Brightness platformBrightness =
        WidgetsBinding.instance.window.platformBrightness;
    _isDarkMode.value = platformBrightness == Brightness.dark;
  }

  Future<void> switchTheme(ThemeMode mode) async {
    try {
      _themeMode.value = mode;

      if (mode == ThemeMode.light) {
        _isDarkMode.value = false;
      } else if (mode == ThemeMode.dark) {
        _isDarkMode.value = true;
      } else {
        _checkSystemTheme();
      }

      final prefs = await SharedPreferences.getInstance();
      switch (mode) {
        case ThemeMode.light:
          await prefs.setString('theme', 'light');
          break;
        case ThemeMode.dark:
          await prefs.setString('theme', 'dark');
          break;
        case ThemeMode.system:
          await prefs.setString('theme', 'system');
          break;
      }
      update();
    } catch (e) {
      // ignore error
    }
  }

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      switchTheme(ThemeMode.dark);
    } else {
      switchTheme(ThemeMode.light);
    }
  }
}