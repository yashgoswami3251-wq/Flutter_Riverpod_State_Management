import 'package:flutter/material.dart';
import 'package:state_management_flutter/Todo_Application/Theme/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Appcolors.background,
    colorScheme: const ColorScheme.dark(
      primary: Appcolors.primary,
      surface: Appcolors.surface,
    ),

      /// Text Field decor
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Appcolors.surface.withAlpha(100),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      )
  ),

    /// Elevated button

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolors.primary,
        foregroundColor: Appcolors.textprimary,
        elevation: 0
      )
    ),

    /// Text button

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Appcolors.textprimary
      )
    ),

    /// Card Theme

    cardTheme: CardThemeData(
      color: Appcolors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )
    )
  );
}