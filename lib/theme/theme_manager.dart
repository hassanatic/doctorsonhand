import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.system;

  setSelectedThemeMode(ThemeMode _themeMode) {
    selectedThemeMode = _themeMode;
    notifyListeners();
  }

  toggleTheme(bool isDark) {
    selectedThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
