import 'package:flutter/material.dart';
import 'dart:math' as math;

class BorderThicknessAndColorChangeAnimation extends StatefulWidget {
  @override
  _BorderThicknessAndColorChangeAnimationState createState() => _BorderThicknessAndColorChangeAnimationState();
}

class _BorderThicknessAndColorChangeAnimationState extends State<BorderThicknessAndColorChangeAnimation> {
  double _borderWidth = 3.0;
  Color _borderColor = Colors.blueAccent;
  final _random = math.Random();

  void toggleBorder() {
    setState(() {
      _borderWidth = _borderWidth == 3.0 ? 10.0 : 3.0;
      _borderColor = Color.fromRGBO(
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
      onTap: toggleBorder,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: _borderColor, width: _borderWidth),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          'Tap to change border',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border Animation',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Border Thickness & Color Change Animation'),
        ),
        body: Center(
          child: BorderThicknessAndColorChangeAnimation(),
        ),
      ),
    );
  }
}
