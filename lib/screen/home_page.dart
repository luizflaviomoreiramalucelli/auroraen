import 'package:aurora_en/screen/vocab_page.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../vocab_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Aurora English'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 25,
            children: [
              ...vocabData.map((v) {
                return Button(
                  text: v.title,
                  onTap: (_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VocabPage(title: v.title, wordList: v.words),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
