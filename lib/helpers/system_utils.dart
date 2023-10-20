import 'package:screen_brightness/screen_brightness.dart';

Future<double> get systemBrightness async {
  try {
    return await ScreenBrightness().system;
  } catch (exception) {
    print(exception.toString());
    throw 'Failed to get systemBrightness';
  }
}

Future<void> setBrightness(double brightness) async {
  try {
    await ScreenBrightness().setScreenBrightness(brightness);
  } catch (e) {
    print(e);
    throw 'Failed to set brightness';
  }
}

Future<double> get currentBrightness async {
  try {
    return await ScreenBrightness().current;
  } catch (e) {
    print(e);
    throw 'Failed to get current brightness';
  }
}

Future<void> resetBrightness() async {
  try {
    await ScreenBrightness().resetScreenBrightness();
  } catch (e) {
    print(e);
    throw 'Failed to reset brightness';
  }
}
