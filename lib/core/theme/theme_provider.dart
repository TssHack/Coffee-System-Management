import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark; // تم پیش‌فرض رو dark گذاشتم

  ThemeMode get themeMode => _themeMode;
  
  bool get isDark {
    if (_themeMode == ThemeMode.system) {
      // اگه روی سیستم باشه، باید چک کنیم فعلاً ساده برمی‌گردونیم
      return true; 
    }
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}