import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:pomodoro_app/themes/theme_provider.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      borderOnForeground: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(themeProvider.secondaryColor).withOpacity(0.4),
                    blurRadius: 10,
                    blurStyle: BlurStyle.solid)
              ],
            ),
            width: 120,
            height: 50,
          ),
          Positioned(
            top: -1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Color(themeProvider.primaryColor).withOpacity(0.9),
              ),
              width: 118,
              height: 50,
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.black54,
            highlightColor: Color(themeProvider.primaryColor),
            period: const Duration(seconds: 10),
            child: Text(
              _timeString,
              style: TextStyle(
                letterSpacing: 2.5,
                color: Color(themeProvider.tertiaryColor),
                fontSize: 24,
                fontFamily: 'Streamster',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
