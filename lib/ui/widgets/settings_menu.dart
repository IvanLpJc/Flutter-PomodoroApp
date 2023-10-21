import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:retrowave_pomodoro_app/helpers/system_utils.dart';
import 'package:retrowave_pomodoro_app/shared_preferences/preferences.dart';
import 'package:retrowave_pomodoro_app/ui/widgets/cassette_main_background.dart';

class SettingsMenu extends StatefulWidget {
  final AnimationController animationController;

  const SettingsMenu({super.key, required this.animationController});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  void dispose() {
    super.dispose();
  }

  _handleBrightnesSetting(double brightness) {
    setState(() {});
    Preferences.screenBrightness = brightness;
    Preferences.customBrightness = true;
    resetBrightness();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SlideInRight(
      from: 400,
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Align(
          alignment: Alignment.centerRight,
          child: Material(
            borderRadius: BorderRadius.circular(25),
            color: Colors.transparent,
            elevation: 5,
            child: SizedBox(
              height: size.height * 0.65,
              width: size.width * 0.4,
              child: Stack(
                children: [
                  CassetteMainBackground(
                    showScrews: false,
                    height: size.height * 0.7,
                    width: size.width * 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(
                              fontFamily: 'Streamster',
                              fontSize: 18,
                              letterSpacing: 5),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                LabeledCheckbox(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  value: Preferences.alwaysOnDisplay,
                                  title: const Text("Always On Display"),
                                  subtitle: const Text(
                                    "This will keep your screen always awake.",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  onChanged: (value) {
                                    Preferences.alwaysOnDisplay = value;
                                    setState(() {});
                                  },
                                ),
                                if (Preferences.alwaysOnDisplay &&
                                    Preferences.customBrightness)
                                  Slider(
                                      value: Preferences.screenBrightness,
                                      onChangeEnd: _handleBrightnesSetting,
                                      onChanged: (double brightness) {
                                        Preferences.screenBrightness =
                                            brightness;
                                        setState(() {});
                                        setBrightness(brightness);
                                      }),
                                if (Preferences.alwaysOnDisplay &&
                                    !Preferences.customBrightness)
                                  FutureBuilder<double>(
                                    future: currentBrightness,
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? Slider(
                                              value: snapshot.data!,
                                              onChangeEnd:
                                                  _handleBrightnesSetting,
                                              onChanged: (double brightness) {
                                                setState(() {});
                                                setBrightness(brightness);
                                              },
                                            )
                                          : Container();
                                    },
                                  ),
                                LabeledCheckbox(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  value: Preferences.videoOnLoop,
                                  title: const Text("Background playing"),
                                  subtitle: const Text(
                                    "This will keep the background reproduction",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  onChanged: (value) {
                                    Preferences.videoOnLoop = value;
                                    setState(() {});
                                  },
                                ),
                                LabeledCheckbox(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  value: Preferences.alertSound,
                                  title: const Text("Alert sound"),
                                  subtitle: const Text(
                                    "When timer finishes",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  onChanged: (value) {
                                    Preferences.alertSound = value;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Preferences.customBrightness = false;
                            Preferences.screenBrightness = 1.0;
                            Preferences.alwaysOnDisplay = false;
                            Preferences.reset();
                            setState(() {});
                          },
                          child: Text('Reset settings',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.title,
    this.subtitle,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final Widget title;
  final Widget? subtitle;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title, if (subtitle != null) subtitle!],
              ),
            ),
            Checkbox(
              activeColor: const Color.fromARGB(255, 173, 92, 187),
              shape: const CircleBorder(),
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
