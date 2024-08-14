import 'package:flutter/material.dart';
import 'bouncing_ball_animation.dart';
import 'rotating_cube_animation.dart';
import 'spinning_wheel_animation.dart';
import 'color_fade_animation.dart';
import 'expanding_circle_animation.dart';
import 'border_thickness_and_color_change_animation.dart';

class AnimationDisplayWidget extends StatelessWidget {
  final String animationType;

  AnimationDisplayWidget({required this.animationType});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Center(
        child: _buildAnimationWidget(animationType),
      ),
    );
  }

  Widget _buildAnimationWidget(String animationType) {
    switch (animationType) {
      case 'Bouncing Ball':
        return BouncingBallAnimation();
      case 'Rotating Cube':
        return RotatingCubeAnimation();
      case 'Spinning Wheel':
        return SpinningWheelAnimation();
      case 'Color Fade':
        return ColorFadeAnimation();
      case 'Expanding Circle':
        return ExpandingCircleAnimation();
      case 'Border Thickness':
        return BorderThicknessAndColorChangeAnimation();
      default:
        return Text('Select an Animation', style: TextStyle(color: Colors.white70));
    }
  }
}
