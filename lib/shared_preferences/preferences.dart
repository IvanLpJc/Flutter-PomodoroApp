import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _alwaysOnDisplay = false;
  static bool _customBrightness = false;
  static double _screenBrightness = 1.0;
  static bool _videoOnLoop = true;
  static bool _alertSound = false;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void reset() => _prefs.clear();

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
}
