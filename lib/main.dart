import 'package:aurora_en/screen/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        // Wrap the child of MaterialApp with MediaQuery to ensure textScaleFactor is 1.0
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('pt', ''),
      // ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
