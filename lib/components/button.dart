import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final GestureTapUpCallback? onTap;

  const Button({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(text, style: TextStyle(fontSize: 26)),
      ),
    );
  }
}