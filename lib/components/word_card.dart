import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../word.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final GestureTapUpCallback? onTap;
  final bool isSelected;

  const WordCard({
    super.key,
    required this.word,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(0, 100, 240, 1.0) : Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(CupertinoIcons.add_circled_solid, size: 40),
            Text(word.word, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
