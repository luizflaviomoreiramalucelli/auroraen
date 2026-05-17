import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../word.dart';

class WordSlide extends StatelessWidget {
  final Word word;
  final VoidCallback leftTap;
  final VoidCallback rightTap;

  const WordSlide({
    super.key,
    required this.word,
    required this.leftTap,
    required this.rightTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      width: kMaxWidth,
      padding: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: isDark ? kDarkAccentColor : kAccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 25,
        children: [
          Text(word.word, style: TextStyle(fontSize: 30, color: Colors.white)),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      word.imgPath,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) {
                        return SizedBox(
                          width: 200,
                          height: 200,
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
              ),
              Positioned(
                left: 0,
                bottom: 0,
                top: 0,
                child: GestureDetector(
                  onTap: leftTap,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.chevron_left,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: GestureDetector(
                  onTap: rightTap,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              word.description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
