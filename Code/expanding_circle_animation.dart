import 'package:flutter/material.dart';

class ExpandingCircleAnimation extends StatefulWidget {
  @override
  _ExpandingCircleAnimationState createState() => _ExpandingCircleAnimationState();
}

class _ExpandingCircleAnimationState extends State<ExpandingCircleAnimation> {
  double _size = 100.0; // Initial size of the circle
  bool isExpanded = false;

  void toggleCircleSize() {
    setState(() {
      if (isExpanded) {
        _size = 100.0;
      } else {
        _size = 200.0;
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCircleSize,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          isExpanded ? 'Tap to shrink' : 'Tap to expand',
          style: TextStyle(
            color: Colors.white,
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
      title: 'Expanding Circle Animation',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expanding Circle Animation'),
        ),
        body: Center(
          child: ExpandingCircleAnimation(),
        ),
      ),
    );
  }
}
