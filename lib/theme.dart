import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primarySwatch = Colors.blue;
  static const Color lightBlue = Color(0xFFADD8E6);
  static const Color darkGrey = Colors.black87;
  static const Color lightGrey = Color.fromRGBO(238, 238, 238, 1);
  static final ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppTheme.lightBlue,
      foregroundColor: AppTheme.darkGrey,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}