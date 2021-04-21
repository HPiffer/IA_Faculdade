import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/pages/game_page.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';

// =========================================== //
// Main Application
// =========================================== //
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: GAME_TITLE,
      theme: myThemeData(),
      home: GamePage(),
    );
  }

  // =========================================== //
  // Personal Theme
  // =========================================== //
  ThemeData myThemeData() {
    return ThemeData(
      //* Define Brightness, Density and Colors.
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.amber,
      buttonTheme: ButtonThemeData(
        height: 52,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
