import 'package:aurora_en/constants.dart';
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
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return GestureDetector(
      onTapUp: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isDark
              ? (isSelected ? kDarkActiveAuroraYellow : kDarkAccentColor)
              : (isSelected ? kActiveAuroraYellow : kAccentColor),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected && isDark ? Colors.white : Colors.transparent,
            width: 2,
          ),
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
            if (word.fileName == null) ...[
              SizedBox(
                width: 80,
                height: 80,
                child: const Icon(
                  CupertinoIcons.photo_fill,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ] else ...[
              ClipOval(
                child: Image.asset(
                  word.imgPath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return SizedBox(
                      width: 80,
                      height: 80,
                      child: Icon(
                        CupertinoIcons.xmark_circle,
                        size: 40,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
            Text(
              word.word.replaceAll(' ', '\n'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
