import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}

enum AlertPopData { firstButton, secondButton, thirdButton, noAction }

class CustomDivider extends StatelessWidget {
  final Color? color;

  const CustomDivider({
    super.key,
    this.color = Colors.grey, // Default color is grey if not specified
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color?.withValues(
        alpha: 0.3,
      ), // Custom opacity can be adjusted here
    );
  }
}

Future<AlertPopData?> showAlert({
  required BuildContext context,
  required String alertTitle,
  required String alertText,
  String? firstButtonText,
  String? secondButtonText,
  String? thirdButtonText,
  VoidCallback? firstButtonAction,
  VoidCallback? secondButtonAction,
  VoidCallback? thirdButtonAction,
  bool onlyFirstButton = false,
  bool onlyFirstButtonOk = true,
  bool allowEnter = false,
}) async {
  // final localizations = AppLocalizations.of(context);
  // final firstButtonText0 = firstButtonText ?? localizations!.yes;
  // final secondButtonText0 = secondButtonText ?? localizations!.no;
  final firstButtonText0 = firstButtonText ?? 'Yes';
  final secondButtonText0 = secondButtonText ?? 'No';

  return showDialog<AlertPopData>(
    context: context,
    barrierDismissible: false, // User must tap button to close the dialog
    builder: (BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double dialogMaxWidth =
          400.0; // Set your desired max width for the dialog
      double padding = screenWidth > dialogMaxWidth
          ? (screenWidth - dialogMaxWidth) / 2
          : 0;

      final brightness = Theme.of(context).brightness;
      return PopScope(
        canPop: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: AlertDialog(
            backgroundColor: (brightness == Brightness.dark)
                ? const Color.fromRGBO(40, 40, 40, 1)
                : Theme.of(context).colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            title: Text(
              alertTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: (brightness == Brightness.dark)
                    ? Colors.white
                    : const Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
            content: (alertText.isNotEmpty)
                ? SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          alertText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: (brightness == Brightness.dark)
                                ? Colors.white
                                : const Color.fromRGBO(30, 30, 30, 1),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.fromLTRB(
              24.0,
              alertText.isNotEmpty ? 10.0 : 0,
              24.0,
              alertText.isNotEmpty ? 24.0 : 0,
            ),
            // Adjust bottom padding based on alertText
            actions: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // Stretch buttons horizontally
                children: [
                  const CustomDivider(),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        minimumSize: const Size(88, 20),
                      ),
                      child: Text(
                        onlyFirstButton && onlyFirstButtonOk
                            ? 'OK'
                            : firstButtonText0,
                        style: const TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        if (firstButtonAction != null) {
                          firstButtonAction();
                        }
                        Navigator.of(context).pop(AlertPopData.firstButton);
                      },
                    ),
                  ),
                  if (!onlyFirstButton) const CustomDivider(),
                  if (!onlyFirstButton)
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        child: Text(
                          secondButtonText0,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          if (secondButtonAction != null) {
                            secondButtonAction();
                          }
                          Navigator.of(context).pop(AlertPopData.secondButton);
                        },
                      ),
                    ),
                  if (!onlyFirstButton && thirdButtonText != null)
                    const CustomDivider(),
                  if (!onlyFirstButton && thirdButtonText != null)
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        child: Text(
                          thirdButtonText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          if (thirdButtonAction != null) {
                            thirdButtonAction();
                          }
                          Navigator.of(context).pop(AlertPopData.thirdButton);
                        },
                      ),
                    ),
                ],
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
            // Center the column of buttons
            actionsPadding: const EdgeInsets.only(
              bottom: 16,
            ), // Adjust padding as needed
          ),
        ),
      );
    },
  );
}

bool get supportsKeyboardShortcuts =>
    kIsWeb || Platform.isWindows || Platform.isMacOS;
