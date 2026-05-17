import 'package:flutter/material.dart';

import '../constants.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const Button({super.key, required this.text, required this.onTap});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          isSelected = false;
        });
        widget.onTap();
      },
      onTapDown: (_) {
        setState(() {
          isSelected = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isSelected = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isDark
              ? (isSelected ? kActiveDarkAccentColor : kDarkAccentColor)
              : (isSelected ? kActiveAccentColor : kAccentColor),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
      ),
    );
  }
}
