import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
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
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      child: Container(
        height: 50,
        width: 120,
        decoration: _getDecoration(),
        child: Center(
            child: Shimmer.fromColors(
          baseColor: Colors.black,
          highlightColor: const Color(0xffB4AFDF),
          period: const Duration(seconds: 10),
          child: Text(
            _timeString,
            style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Streamster',
                fontWeight: FontWeight.bold),
          ),
        )),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      border:
          Border.all(color: const Color(0xffB4AFDF).withOpacity(0.4), width: 2),
      boxShadow: const [
        BoxShadow(
            color: Color(0xffAD48E2),
            blurRadius: 5,
            spreadRadius: 2,
            blurStyle: BlurStyle.inner,
            offset: Offset(3, 3)),
      ],
    );
  }
}
