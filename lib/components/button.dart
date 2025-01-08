import 'package:flutter/material.dart';
/// A custom button widget that displays a circular button with optional text.
///
/// The [MyButton] widget is a stateless widget that creates a circular button
/// using a [ClipOval] and a [Container]. The button can have a background color,
/// optional text, and text color.
///
/// The [color] parameter is required and specifies the background color of the button.
/// The [text] parameter is optional and specifies the text to be displayed inside the button.
/// If [text] is null, an empty string will be displayed.
/// The [textcolor] parameter is required and specifies the color of the text.
///
/// Example usage:
/// ```dart
/// MyButton(
///   color: Colors.blue,
///   text: "Click Me",
///   textcolor: Colors.white,
/// )
/// ```

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
