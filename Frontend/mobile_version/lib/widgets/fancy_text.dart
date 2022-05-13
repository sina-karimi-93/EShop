import 'package:flutter/material.dart';

class FancyText extends StatelessWidget {
  const FancyText({
    required this.text,
    required this.fontSize,
    required this.letterSpacing,
    required this.outlineColor,
    required this.inlineColor,
    Key? key,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final double letterSpacing;
  final outlineColor;
  final inlineColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          style: TextStyle(
            letterSpacing: letterSpacing,
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = outlineColor,
          ),
        ),
        // Solid text as fill.
        Text(
          text,
          style: TextStyle(
            letterSpacing: letterSpacing,
            fontSize: fontSize,
            color: inlineColor,
          ),
        ),
      ],
    );
  }
}
