import 'package:aurora_en/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class Screen extends StatelessWidget {
  final List<Widget> widgets;
  final String? title;
  final bool footer;
  final double widgetSpacing;

  const Screen({
    super.key,
    required this.widgets,
    this.title,
    this.footer = false,
    this.widgetSpacing = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kAuroraYellow, //change your color here
        ),
        backgroundColor: kAuroraRed,
        title: Text(
          title ?? 'Aurora English',
          style: TextStyle(
            color: kAuroraYellow,
            fontWeight: supportsKeyboardShortcuts
                ? FontWeight.w500
                : FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: kMaxWidth),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(spacing: widgetSpacing, children: widgets),
                  ),
                ),
              ),
            ),
            if (footer) ...[
              const Text(
                'Developed by\nEmpatia Produtos Psicopedagógicos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              if (kIsWeb) SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
