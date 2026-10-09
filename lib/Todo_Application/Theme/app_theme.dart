import 'package:flutter/material.dart';
import 'package:state_management_flutter/Todo_Application/Theme/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Appcolors.background
  );
}