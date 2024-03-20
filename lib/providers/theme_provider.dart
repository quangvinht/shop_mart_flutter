

import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadThemeStatus();
  }

  static const THEME_STATUS = "THEME_STATUS";

  Future<void> _loadThemeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(THEME_STATUS) ?? false;
    state = isDarkTheme;
  }

  Future<void> setDarkTheme(bool themeValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_STATUS, themeValue);
    state = themeValue;
  }
}

// Tạo một provider để truy cập ThemeNotifier
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
