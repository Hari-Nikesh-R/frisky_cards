import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationWidget extends StatefulWidget {
  @override
  _CelebrationWidgetState createState() => _CelebrationWidgetState();
}

class _CelebrationWidgetState extends State<CelebrationWidget> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    startTimer();
  }

  late Timer _timer;
  int _start = 2;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ConfettiWidget(
          confettiController: _controllerCenter,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ),
      ],
    );
  }
}
