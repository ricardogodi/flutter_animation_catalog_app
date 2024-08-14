import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  @override
  _BouncingBallAnimationState createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool isPlaying = false; // Initialize as false to start with the animation paused

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
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
          child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              return Center(
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 12,
                        spreadRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: _animation!.value),
                ),
              );
            },
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
