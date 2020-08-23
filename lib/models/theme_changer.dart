import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  bool _isDarkTheme;

  ThemeChanger(this._isDarkTheme);

  getTheme() => _isDarkTheme;

  changeTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }
}
