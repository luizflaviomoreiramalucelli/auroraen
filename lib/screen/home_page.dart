import 'package:aurora_en/screen/about_page.dart';
import 'package:aurora_en/screen/exercises_page.dart';
import 'package:aurora_en/components/screen.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      footer: true,
      widgets: [
        Button(
          text: 'Exercises',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExercisesPage()),
            );
          },
        ),
        Button(
          text: 'About',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          },
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
