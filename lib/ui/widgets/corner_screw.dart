import 'package:flutter/material.dart';

class CornerScrew extends StatelessWidget {
  final double size;
  const CornerScrew({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final screwSize = size * 0.08912;
    final double position = size * 0.0237;
    return Material(
      elevation: 5,
      shape: const CircleBorder(),
      child: Stack(
        children: [
          Container(
            height: screwSize, //35
            width: screwSize, //35
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Positioned(
            left: position,
            top: position,
            child: Container(
              // height: size - 20, //15
              // width: size - 20, //15
              height: size * 0.03819,
              width: size * 0.03819,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 15,
                    color: Colors.white.withOpacity(0.7),
                  )
                ],
                // color: Colors.white,
                gradient: RadialGradient(
                    center: Alignment.topLeft,
                    tileMode: TileMode.mirror,
                    colors: [
                      Colors.transparent,
                      Colors.purple.withOpacity(0.8)
                    ]),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
