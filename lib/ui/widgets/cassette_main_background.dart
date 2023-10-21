import 'package:flutter/material.dart';
import 'package:retrowave_pomodoro_app/ui/widgets/widgets.dart';

class CassetteMainBackground extends StatelessWidget {
  final double height;
  final double width;
  final bool showScrews;
  final bool showClock;

  const CassetteMainBackground(
      {super.key,
      required this.height,
      required this.width,
      this.showClock = false,
      this.showScrews = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffB4AFDF).withOpacity(0.4),
                  // offset: Offset(-1, -1),
                  blurRadius: 40,
                  blurStyle: BlurStyle.solid)
            ],
            border: Border.all(color: const Color(0xffB4AFDF), width: 1),
            // color: const Color.fromARGB(255, 173, 92, 187)
            //     .withOpacity(0.7),
          ),
          width: width,
          height: height,
        ),
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(255, 173, 92, 187).withOpacity(0.7),
          ),
          width: width,
          height: height,
        ),
        if (showScrews)
          Positioned(
            top: 15,
            left: 15,
            child: CornerScrew(
              size: height,
            ),
          ),
        if (showScrews)
          Positioned(
            top: 15,
            right: 15,
            child: CornerScrew(
              size: height,
            ),
          ),
        if (showScrews)
          Positioned(
            bottom: 15,
            right: 15,
            child: CornerScrew(
              size: height,
            ),
          ),
        if (showScrews)
          Positioned(
            bottom: 15,
            left: 15,
            child: CornerScrew(
              size: height,
            ),
          ),
        if (showClock) const Clock(),

        // Positioned(
        //   child: Container(
        //     width: width * 0.55,
        //     height: height * 0.2,
        //     color: const Color.fromARGB(255, 173, 92, 187).withOpacity(0.9),
        //   ),
        // ),
        // Positioned(
        //   child: Container(
        //     width: width * 0.52,
        //     height: height * 0.18,
        //     // color: const Color.fromARGB(255, 173, 92, 187).withOpacity(0.9),
        //     color: Colors.red,
        //   ),
        // ),
      ],
    );
  }
}
