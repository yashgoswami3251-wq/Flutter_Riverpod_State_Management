import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management_flutter/Todo_Application/Theme/app_theme.dart';
import 'package:state_management_flutter/Todo_Application/todo_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.themeData,
      home: todoscreen(),
    );
  }
}
