import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedMenuButton extends StatelessWidget {
  final AnimationController controller;
  final Function()? onPressed;
  Animation<double> animation;

  AnimatedMenuButton({super.key, required this.controller, this.onPressed})
      : animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 20,
      child: IconButton(
        onPressed: onPressed,
        icon: AnimatedIcon(
          color: Colors.purple,
          icon: AnimatedIcons.menu_close,
          size: 35,
          progress: animation,
        ),
      ),
    );
  }
}
