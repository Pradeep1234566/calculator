import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String? text;
  final Color textcolor;

  const MyButton(
      {super.key, required this.color, this.text, required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      // Changed to ClipOval for circular buttons
      child: Container(
        color: color,
        child: Center(
          child: Text(
            text ?? "", // Provide a default empty string if text is null
            style: TextStyle(color: textcolor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
