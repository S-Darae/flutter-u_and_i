import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // Korean
      ],
      title: 'U and I',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 232, 240),
        ),
        useMaterial3: true,
        fontFamily: 'Pretendard',
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Color.fromARGB(255, 75, 53, 68),
              fontSize: 57,
              fontWeight: FontWeight.w600,
            ),
            headlineMedium: TextStyle(
              color: Color.fromARGB(210, 225, 83, 130),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: TextStyle(
              color: Color.fromARGB(230, 75, 53, 68),
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            bodyMedium: TextStyle(
              color: Color.fromARGB(230, 75, 53, 68),
              fontWeight: FontWeight.w500,
              fontSize: 21,
            )),
      ),
      home: const HomeScreen(),
    );
  }
}
