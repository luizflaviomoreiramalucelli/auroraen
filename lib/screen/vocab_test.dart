import 'package:aurora_en/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/button.dart';
import '../components/word_card.dart';
import '../utils.dart';
import '../word.dart';

class VocabTest extends StatefulWidget {
  const VocabTest({super.key, required this.title, required this.wordList});

  final String title;
  final List<Word> wordList;

  @override
  State<VocabTest> createState() => _VocabTestState();
}

class _VocabTestState extends State<VocabTest> {
  late List<Word> _items;
  late List<Word> _answers;
  int currIndex = 0;
  String currWord = '';
  int attempts = 0;
  double score = 0;
  bool dialogOpen = false;
  bool userFailed = false;
  bool quizDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _items = widget.wordList.toList()..shuffle();
    _answers = widget.wordList.toList()..shuffle();
    if (supportsKeyboardShortcuts) {
      HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    }
  }

  @override
  void dispose() {
    if (supportsKeyboardShortcuts) {
      HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kAuroraYellow, //change your color here
        ),
        backgroundColor: kAuroraRed,
        title: Text(
          widget.title,
          style: TextStyle(
            color: kAuroraYellow,
            fontWeight: supportsKeyboardShortcuts
                ? FontWeight.w500
                : FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  _answers[currIndex].description,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              // const SizedBox(height: 5),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        constraints: BoxConstraints(maxWidth: kMaxWidth),
                        child: Column(
                          children: [
                            SizedBox(height: 35),
                            Wrap(
                              spacing: 20,
                              alignment: WrapAlignment.center,
                              runSpacing: 20,
                              children: [
                                ..._items.map((w) {
                                  final isSelected = w.word == currWord;

                                  return WordCard(
                                    word: w,
                                    onTap: (_) {
                                      setState(() {
                                        currWord = w.word;
                                      });
                                    },
                                    isSelected: isSelected,
                                  );
                                }),
                              ],
                            ),
                            SizedBox(height: 35),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).colorScheme.surface,
                              Theme.of(
                                context,
                              ).colorScheme.surface.withAlpha(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.surface.withAlpha(0),
                              Theme.of(context).colorScheme.surface,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Button(text: 'Confirm', onTap: _handleConfirm),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleConfirm() async {
    if (currWord.isEmpty) {
      _confirmAlert('You must choose a word');
      return;
    }
    const maxAttempts = 3;
    const scorePoints = [100, 80, 60];

    if (currWord == _answers[currIndex].word) {
      if (attempts < scorePoints.length) {
        score += scorePoints[attempts];
      }
      await _confirmAlert('Correct');
      if (await _checkQuizComplete()) return;
      _nextWord();
    } else {
      attempts++;
      if (attempts < maxAttempts) {
        await _confirmAlert('Try again');
      } else {
        await _confirmAlert('Next word');
        if (await _checkQuizComplete()) return;
        _nextWord();
      }
    }
    currWord = '';
    setState(() {});
  }

  void _nextWord() async {
    currIndex++;
    attempts = 0;
  }

  Future<AlertPopData?> _confirmAlert(String alertText) async {
    dialogOpen = true;
    try {
      return await showAlert(
        context: context,
        alertTitle: alertText,
        alertText: '',
        onlyFirstButton: true,
      );
    } finally {
      dialogOpen = false;
    }
  }

  Future<bool> _checkQuizComplete() async {
    final length = _answers.length;
    if (currIndex >= length - 1) {
      int finalScore = score ~/ length;
      final failed = finalScore < 60;
      quizDialogOpen = true;
      await showAlert(
        context: context,
        alertTitle: 'SCORE: $finalScore%',
        alertText: '',
        firstButtonText: 'Go again',
        secondButtonText: 'End',
        firstButtonAction: _restart,
        secondButtonAction: Navigator.of(context).pop,
        onlyFirstButton: failed,
        onlyFirstButtonOk: false,
      );
      quizDialogOpen = false;
      setState(() {});
      return true;
    }
    return false;
  }

  void _restart() {
    _items.shuffle();
    _answers.shuffle();
    score = 0;
    currWord = '';
    currIndex = 0;
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (!dialogOpen && !quizDialogOpen) {
          _handleConfirm();
        } else if (dialogOpen) {
          Navigator.of(context).pop();
        } else if (quizDialogOpen) {}
      }
    }
    return false;
  }
}
