import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class todoscreen extends StatefulWidget {
  const todoscreen({super.key});

  @override
  State<todoscreen> createState() => _todoscreenState();
}

class _todoscreenState extends State<todoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No todo's Yet"),
      ),
    );
  }
}
