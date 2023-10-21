import 'package:flutter/foundation.dart';
import 'package:pomodoro_app/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _alwaysOnDisplay = false;
  static bool _customBrightness = false;
  static double _screenBrightness = 1.0;
  static bool _videoOnLoop = true;
  static bool _alertSound = false;

  static int _primaryColor = kPrimaryPink;
  static int _secondaryColor = kPrimarySkyblue;
  static int _terciaryColor = kPrimarySkyblue;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void reset() {
    if (kDebugMode) {
      print("Resetting preferences...");
    }
    _prefs.clear();
  }

  static bool get alwaysOnDisplay {
    return _prefs.getBool('alwaysOnDisplay') ?? _alwaysOnDisplay;
  }

  static set alwaysOnDisplay(bool value) {
    _alwaysOnDisplay = value;
    _prefs.setBool('alwaysOnDisplay', _alwaysOnDisplay);
  }

  static bool get customBrightness {
    return _prefs.getBool('customBrightness') ?? _customBrightness;
  }

  static set customBrightness(bool value) {
    _customBrightness = value;
    _prefs.setBool('customBrightness', _customBrightness);
  }

  static double get screenBrightness {
    return _prefs.getDouble('screenBrightness') ?? _screenBrightness;
  }

  static set screenBrightness(double value) {
    _screenBrightness = value;
    _prefs.setDouble('screenBrightness', _screenBrightness);
  }

  static bool get videoOnLoop {
    return _prefs.getBool('videoOnLoop') ?? _videoOnLoop;
  }

  static set videoOnLoop(bool value) {
    _videoOnLoop = value;
    _prefs.setBool('videoOnLoop', _videoOnLoop);
  }

  static bool get alertSound {
    return _prefs.getBool('alertSound') ?? _alertSound;
  }

  static set alertSound(bool value) {
    _alertSound = value;
    _prefs.setBool('alertSound', _alertSound);
  }

  static int get primaryColor {
    return _prefs.getInt('mainColor') ?? _primaryColor;
  }

  static set primaryColor(int color) {
    _primaryColor = color;
    _prefs.setInt('mainColor', color);
  }

  static int get secondaryColor {
    return _prefs.getInt('detailsColor') ?? _secondaryColor;
  }

  static set secondaryColor(int color) {
    _secondaryColor = color;
    _prefs.setInt('detailsColor', color);
  }

  static int get terciaryColor {
    return _prefs.getInt('detailsColor') ?? _terciaryColor;
  }

  static set terciaryColor(int color) {
    _terciaryColor = color;
    _prefs.setInt('detailsColor', color);
  }
}
