import 'package:flutter/material.dart';
import 'package:pomodoro_app/shared_preferences/preferences.dart';
import 'package:pomodoro_app/themes/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  int _primaryColor = kPrimaryPink;
  int _secondaryColor = kPrimaryLightBlue;
  int _tertiaryColor = kPrimaryPurple;

  int get primaryColor => _primaryColor;

  set primaryColor(int color) {
    _primaryColor = color;
    Preferences.primaryColor = color;
    notifyListeners();
  }

  int get secondaryColor => _secondaryColor;

  set secondaryColor(int color) {
    _secondaryColor = color;
    Preferences.secondaryColor = color;
    notifyListeners();
  }

  int get tertiaryColor => _tertiaryColor;

  set tertiaryColor(int color) {
    _tertiaryColor = color;
    Preferences.tertiaryColor = color;
    notifyListeners();
  }
}
