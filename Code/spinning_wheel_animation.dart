import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpinningWheelAnimation extends StatefulWidget {
  @override
  _SpinningWheelAnimationState createState() => _SpinningWheelAnimationState();
}

class _SpinningWheelAnimationState extends State<SpinningWheelAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _rotationAnimation;
  bool isPlaying = false; // Start with the animation paused

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AnimatedBuilder(
              animation: _rotationAnimation!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation!.value,
                  child: CustomPaint(
                    painter: WheelPainter(),
                    size: Size(200, 200),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  if (isPlaying) {
                    _controller?.stop(); // This pauses the animation
                    isPlaying = false;
                  } else {
                    _controller?.forward(); // This plays the animation forward
                    isPlaying = true;
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  if (_controller!.status == AnimationStatus.forward || _controller!.status == AnimationStatus.completed) {
                    _controller!.reverse();
                  } else if (_controller!.status == AnimationStatus.reverse || _controller!.status == AnimationStatus.dismissed) {
                    _controller!.forward();
                  }
                  isPlaying = true; // Ensure the animation continues to play in the new direction
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class WheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the circle
    final paint = Paint()..color = Colors.blueGrey;
    canvas.drawCircle(center, radius, paint);

    // Draw the spokes
    final spokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = (2 * math.pi / 8) * i;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), spokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
