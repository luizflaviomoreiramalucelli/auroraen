import 'package:aurora_en/components/screen.dart';
import 'package:aurora_en/screen/vocab_learn.dart';
import 'package:aurora_en/screen/vocab_test.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../vocab.dart';

class VocabPage extends StatelessWidget {
  final Vocab vocab;

  const VocabPage({super.key, required this.vocab});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: vocab.title,
      widgets: [
        Button(
          text: 'Learn',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VocabLearn(vocab: vocab)),
            );
          },
        ),
        Button(
          text: 'Practice',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VocabTest(title: vocab.title, wordList: vocab.words),
              ),
            );
          },
        ),
      ],
    );
  }
}
