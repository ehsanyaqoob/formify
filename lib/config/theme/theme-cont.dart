// lib/controllers/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  final RxBool _isDarkMode = false.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
    _checkSystemTheme();
    _setupSystemThemeListener();
  }

  void _setupSystemThemeListener() {
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () => _checkSystemThemeAndUpdate(),
      ),
    );
  }

  void _checkSystemThemeAndUpdate() {
    final bool wasDarkMode = _isDarkMode.value;
    _checkSystemTheme();
    
    // Only update if the system theme changed and we're in system mode
    if (_themeMode.value == ThemeMode.system && wasDarkMode != _isDarkMode.value) {
      update();
    }
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String theme = prefs.getString('theme') ?? 'system';
      
      switch (theme) {
        case 'light':
          _themeMode.value = ThemeMode.light;
          _isDarkMode.value = false;
          break;
        case 'dark':
          _themeMode.value = ThemeMode.dark;
          _isDarkMode.value = true;
          break;
        default:
          _themeMode.value = ThemeMode.system;
          _checkSystemTheme();
          break;
      }
    } catch (e) {
      // Fallback to system theme if loading fails
      _themeMode.value = ThemeMode.system;
      _checkSystemTheme();
    }
  }

  void _checkSystemTheme() {
    final Brightness platformBrightness = WidgetsBinding.instance.window.platformBrightness;
    _isDarkMode.value = platformBrightness == Brightness.dark;
  }

  Future<void> switchTheme(ThemeMode mode) async {
    try {
      _themeMode.value = mode;
      
      // Update dark mode status based on the new theme mode
      if (mode == ThemeMode.light) {
        _isDarkMode.value = false;
      } else if (mode == ThemeMode.dark) {
        _isDarkMode.value = true;
      } else {
        _checkSystemTheme(); // System mode - check current system theme
      }
      
      // Save preference
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
      // Handle or log the error if needed
    }
  }

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      switchTheme(ThemeMode.dark);
    } else {
      switchTheme(ThemeMode.light);
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(
      LifecycleEventHandler(resumeCallBack: () => _checkSystemThemeAndUpdate()),
    );
    super.onClose();
  }
}

// Helper class for lifecycle events
class LifecycleEventHandler extends WidgetsBindingObserver {
  final VoidCallback resumeCallBack;

  LifecycleEventHandler({required this.resumeCallBack});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // No action needed for these states
        break;
    }
  }
}