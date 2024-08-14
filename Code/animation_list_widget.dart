import 'package:flutter/material.dart';

// AnimationListWidget widget displays a list of animations to choose from.
class AnimationListWidget extends StatefulWidget {
  final Function(String) onSelectAnimation;
  final String selectedAnimation;
  final bool isFullWidth;

  AnimationListWidget({
    required this.onSelectAnimation,
    required this.selectedAnimation,
    required this.isFullWidth,
  });

  @override
  _AnimationListWidgetState createState() => _AnimationListWidgetState();
}

class _AnimationListWidgetState extends State<AnimationListWidget> {
  @override
  Widget build(BuildContext context) {
    double tileFontSize = widget.isFullWidth ? 16 : 12;

    return SafeArea(
      child: Column(
        children: [
          if (widget.isFullWidth)
            SizedBox(height: 20),
          if (widget.isFullWidth)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choose an Animation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              itemCount: 6,
              itemBuilder: (context, index) {
                String title;
                switch (index) {
                  case 0:
                    title = 'Bouncing Ball';
                    break;
                  case 1:
                    title = 'Rotating Cube';
                    break;
                  case 2:
                    title = 'Spinning Wheel';
                    break;
                  case 3:
                    title = 'Color Fade';
                    break;
                  case 4:
                    title = 'Expanding Circle';
                    break;
                  case 5:
                    title = 'Border Thickness';
                    break;
                  default:
                    title = ''; // Fallback, should not occur
                }
                bool isSelected = widget.selectedAnimation == title;
                return _buildListTile(title, isSelected, tileFontSize);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build a list tile for each animation option.
  Widget _buildListTile(String title, bool isSelected, double fontSize) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      color: isSelected ? Colors.lightBlueAccent : Theme.of(context).cardTheme.color,
      elevation: Theme.of(context).cardTheme.elevation,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: fontSize,
          ),
          softWrap: true,
        ),
        onTap: () {
          widget.onSelectAnimation(title);
        },
      ),
    );
  }
}