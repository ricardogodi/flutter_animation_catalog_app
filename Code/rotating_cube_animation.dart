import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingCubeAnimation extends StatefulWidget {
  @override
  _RotatingCubeAnimationState createState() => _RotatingCubeAnimationState();
}

class _RotatingCubeAnimationState extends State<RotatingCubeAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _rotationAnimation;
  bool isPlaying = false; // Initialize as false to start with the animation paused

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

    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller?.forward();
      }
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
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    ..rotateY(_rotationAnimation!.value), // Rotate only around the Y-axis
                  alignment: FractionalOffset.center,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.8),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
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
                    _controller?.stop(canceled: false);
                  } else {
                    // Resume animation in its current direction
                    if (_controller?.status == AnimationStatus.reverse) {
                      _controller?.reverse();
                    } else {
                      _controller?.forward();
                    }
                  }
                  isPlaying = !isPlaying;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  // Reverse the direction even if paused
                  if (_controller?.status == AnimationStatus.forward || _controller?.status == AnimationStatus.dismissed) {
                    _controller?.reverse();
                  } else {
                    _controller?.forward();
                  }
                  if (!isPlaying) {
                    isPlaying = true;
                  }
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
