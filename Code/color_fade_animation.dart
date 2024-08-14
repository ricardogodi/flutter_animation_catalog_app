import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorFadeAnimation extends StatefulWidget {
  @override
  _ColorFadeAnimationState createState() => _ColorFadeAnimationState();
}

class _ColorFadeAnimationState extends State<ColorFadeAnimation> {
  Color _color = Colors.blue;
  final _random = math.Random();

  void changeColor() {
    setState(() {
      _color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeColor,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _color,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Tap to change color',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
