import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Jost'),
      bodyMedium: TextStyle(fontFamily: 'Jost'),
      bodySmall: TextStyle(fontFamily: 'Jost'),
      displayLarge: TextStyle(fontFamily: 'Jost'),
      displayMedium: TextStyle(fontFamily: 'Jost'),
      displaySmall: TextStyle(fontFamily: 'Jost'),
      headlineLarge: TextStyle(fontFamily: 'Jost'),
      headlineMedium: TextStyle(fontFamily: 'Jost'),
      headlineSmall: TextStyle(fontFamily: 'Jost'),
      labelLarge: TextStyle(fontFamily: 'Jost'),
      labelMedium: TextStyle(fontFamily: 'Jost'),
      labelSmall: TextStyle(fontFamily: 'Jost'),
      titleLarge: TextStyle(fontFamily: 'Jost'),
      titleMedium: TextStyle(fontFamily: 'Jost'),
      titleSmall: TextStyle(fontFamily: 'Jost'),
    ),
    scaffoldBackgroundColor: DarkColors.background,
    appBarTheme: const AppBarTheme(
      // titleSpacing: 0,
      backgroundColor: kBlackColor,
      foregroundColor: kWhiteColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkColors.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kBlackColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 18,
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: DarkColors.backgroundLight,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.border2, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.border2, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.border2, width: 4),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: DarkColors.primary,
      foregroundColor: kWhiteColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kWhiteColor,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: DarkColors.background,
      indicatorColor: DarkColors.primary,
    ),
  );

  static final lightTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: kWhiteColor,
    appBarTheme: const AppBarTheme(
      // titleSpacing: 0,
      backgroundColor: DarkColors.primary,
      foregroundColor: kWhiteColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkColors.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: DarkColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 18,
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.grey,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.border2, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.border2, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.border2, width: 4),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: DarkColors.primary,
      foregroundColor: kWhiteColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kWhiteColor,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: DarkColors.background,
      indicatorColor: DarkColors.primary,
    ),
  );
}
