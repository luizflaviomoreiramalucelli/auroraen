import 'package:aurora_en/components/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/word_slide.dart';
import '../vocab.dart';

class VocabLearn extends StatefulWidget {
  final Vocab vocab;

  const VocabLearn({super.key, required this.vocab});

  @override
  State<VocabLearn> createState() => _VocabLearnState();
}

class _VocabLearnState extends State<VocabLearn> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double initialDragX = 0.0;
    double dragDistance = 0.0;

    return Screen(
      title: widget.vocab.title,
      widgets: [
        GestureDetector(
          onHorizontalDragStart: (details) {
            initialDragX = details.globalPosition.dx;
          },
          onHorizontalDragUpdate: (details) {
            dragDistance = details.globalPosition.dx - initialDragX;
          },
          onHorizontalDragEnd: (details) {
            if (dragDistance < -30) {
              nextSlide();
            } else if (dragDistance > 30) {
              previousSlide();
            }
          },
          child: WordSlide(
            word: widget.vocab.words[index],
            leftTap: previousSlide,
            rightTap: nextSlide,
          ),
        ),
      ],
    );
  }

  void nextSlide() {
    int length = widget.vocab.words.length;
    setState(() {
      if (index == length - 1) {
        index = 0;
      } else {
        index++;
      }
    });
  }

  void previousSlide() {
    int length = widget.vocab.words.length;
    setState(() {
      if (index == 0) {
        index = length - 1;
      } else {
        index--;
      }
    });
  }
}
