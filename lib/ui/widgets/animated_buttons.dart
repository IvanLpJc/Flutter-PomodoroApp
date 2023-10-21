// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/themes/theme_provider.dart';

class AnimatedMenuButton extends StatelessWidget {
  final AnimationController controller;
  final Function()? onPressed;
  Animation<double> animation;

  AnimatedMenuButton({super.key, required this.controller, this.onPressed})
      : animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      onPressed: onPressed,
      icon: AnimatedIcon(
        color: Color(themeProvider.terciaryColor),
        icon: AnimatedIcons.menu_close,
        size: 35,
        progress: animation,
      ),
    );
  }
}

class AnimatedPlayButton extends StatelessWidget {
  final AnimationController controller;
  final Function()? onPressed;
  Animation<double> animation;

  AnimatedPlayButton({super.key, required this.controller, this.onPressed})
      : animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: Colors.transparent,
      child: InkResponse(
        borderRadius: BorderRadius.circular(5),
        radius: 25,
        splashFactory: InkRipple.splashFactory,
        highlightShape: BoxShape.rectangle,
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color:
                          Color(themeProvider.secondaryColor).withOpacity(0.4),
                      // offset: Offset(-1, -1),
                      blurRadius: 10,
                      blurStyle: BlurStyle.solid)
                ],
                border: Border.all(
                    color: Color(themeProvider.secondaryColor), width: 2),
                // color: const Color.fromARGB(255, 173, 92, 187)
                //     .withOpacity(0.7),
              ),
              width: 40,
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(themeProvider.primaryColor).withOpacity(0.9),
              ),
              width: 38,
              height: 38,
            ),
            AnimatedIcon(
              color: Color(themeProvider.terciaryColor),
              icon: AnimatedIcons.play_pause,
              size: 35,
              progress: animation,
            ),
          ],
        ),
      ),
    );
  }
}
