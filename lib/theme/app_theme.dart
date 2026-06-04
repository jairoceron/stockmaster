import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.amberAccent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amberAccent,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
    cardTheme: CardThemeData(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.amber,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle: TextStyle(color: Colors.amberAccent),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amberAccent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amberAccent,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    cardTheme: CardThemeData(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey.shade900,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.amberAccent,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.grey,
      contentTextStyle: TextStyle(color: Colors.black),
    ),
  );
}
