import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _isDarkTheme;

  ThemeChanger(this._isDarkTheme);

  getTheme() => _isDarkTheme;

  changeTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }
}
