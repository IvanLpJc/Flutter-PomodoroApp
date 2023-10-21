import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retrowave_pomodoro_app/shared_preferences/preferences.dart';
import 'package:retrowave_pomodoro_app/ui/pages/home_page.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Wakelock.toggle(enable: Preferences.alwaysOnDisplay);

    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pomodoro App',
        home: HomePage());
  }
}
