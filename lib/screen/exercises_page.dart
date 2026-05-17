import 'package:aurora_en/components/screen.dart';
import 'package:aurora_en/screen/vocab_page.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../vocab_data.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Exercises',
      widgets: [
        ...vocabData.map((v) {
          return Button(
            text: v.title,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VocabPage(vocab: v)),
              );
            },
          );
        }),
      ],
    );
  }
}
