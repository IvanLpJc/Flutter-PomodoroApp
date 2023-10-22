import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'package:pomodoro_app/helpers/system_utils.dart';
import 'package:pomodoro_app/shared_preferences/preferences.dart';
import 'package:pomodoro_app/themes/theme_provider.dart';
import 'package:pomodoro_app/ui/widgets/widgets.dart';

class SettingsMenu extends StatefulWidget {
  final AnimationController animationController;
  final ThemeProvider themeProvider;

  const SettingsMenu(
      {super.key,
      required this.animationController,
      required this.themeProvider});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  ThemeProvider get themeProvider => widget.themeProvider;

  @override
  void initState() {
    super.initState();
  }

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
              width: size.width * 0.7,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CassetteMainBackground(
                    showScrews: false,
                    height: size.height * 0.7,
                    width: size.width * 0.7,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: const Text(
                      'Settings',
                      style: TextStyle(
                          fontFamily: 'Streamster',
                          fontSize: 18,
                          letterSpacing: 5),
                    ),
                  ),
                  _ResetOptions(
                    onTap: () {
                      Preferences.reset();
                      setState(() {});
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    height: size.height * 0.65,
                    width: size.width * 0.7,
                    child: Row(
                      children: [
                        _getLeftColumn(size.width * 0.35, size.height * 0.65),
                        _getRightColumn(size),
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

  Container _getRightColumn(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 5),
      height: size.height * 0.65,
      width: size.width * 0.35,
      child: const Column(
        children: [
          ColorSelector(
            colorLevel: ColorLevel.primary,
          ),
          ColorSelector(
            colorLevel: ColorLevel.secondary,
          ),
          ColorSelector(
            colorLevel: ColorLevel.tertiary,
          ),
        ],
      ),
    );
  }

  Widget _getLeftColumn(double width, double height) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabeledCheckbox(
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
                          Preferences.screenBrightness = brightness;
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
                                onChangeEnd: _handleBrightnesSetting,
                                onChanged: (double brightness) {
                                  setState(() {});
                                  setBrightness(brightness);
                                },
                              )
                            : Container();
                      },
                    ),
                  LabeledCheckbox(
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
        ],
      ),
    );
  }
}

class _ResetOptions extends StatelessWidget {
  final Function()? onTap;

  const _ResetOptions({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      child: GestureDetector(
        onTap: onTap,
        child: Text('Reset settings',
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.title,
    this.subtitle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              activeColor: Color(themeProvider.primaryColor),
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
