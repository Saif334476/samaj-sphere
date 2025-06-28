import 'package:flutter/material.dart';

class AppTheme {
  static const primaryBlue = Color(0xFF2074B5);
  static const secondaryOrange = Color(0xFFF59230);
  static const backgroundLight = Color(0xFFF9FAFB);
  static const textDark = Color(0xFF1F2937);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundLight,
    primaryColor: primaryBlue,
    cardColor: Colors.white, // for lightTheme
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: secondaryOrange,
    ),
    inputDecorationTheme: InputDecorationTheme(

      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textDark),

    ),
  );

  static ThemeData darkTheme = ThemeData(
    cardColor: const Color(0xFF1E1E1E),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: secondaryOrange,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );
}
