import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/shared_preferences/preferences.dart';
import 'package:pomodoro_app/themes/theme_provider.dart';

import '../../themes/app_colors.dart';

enum ColorLevel { primary, secondary, terciary }

class ColorSelector extends StatefulWidget {
  final ColorLevel colorLevel;

  const ColorSelector({super.key, required this.colorLevel});

  @override
  State<ColorSelector> createState() => ColorSelectorState();
}

class ColorSelectorState extends State<ColorSelector> {
  late int _selectedColor;
  late String title;

  ColorLevel get colorLevel => widget.colorLevel;

  @override
  void initState() {
    _getSelectedColor();
    _getTitle();
    super.initState();
  }

  _getSelectedColor() {
    switch (colorLevel) {
      case ColorLevel.primary:
        _selectedColor = colors.indexOf(Preferences.primaryColor);
        break;
      case ColorLevel.secondary:
        _selectedColor = colors.indexOf(Preferences.secondaryColor);
        break;
      case ColorLevel.terciary:
        _selectedColor = colors.indexOf(Preferences.terciaryColor);
        break;
    }
  }

  _getTitle() {
    switch (colorLevel) {
      case ColorLevel.primary:
        title = 'Primary color';
        break;
      case ColorLevel.secondary:
        title = 'Secondary color';
        break;
      case ColorLevel.terciary:
        title = 'Terciary color';
        break;
    }
  }

  _setColor(int index, ThemeProvider themeProvider) {
    _selectedColor = index;

    switch (colorLevel) {
      case ColorLevel.primary:
        themeProvider.primaryColor = colors[index];
        break;
      case ColorLevel.secondary:
        themeProvider.secondaryColor = colors[index];
        break;
      case ColorLevel.terciary:
        themeProvider.terciaryColor = colors[index];
        break;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(
          height: 25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  _setColor(index, themeProvider);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 25,
                  decoration: BoxDecoration(
                    color: Color(colors[index]),
                    border: _selectedColor == index
                        ? Border.all(color: Colors.white)
                        : null,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
