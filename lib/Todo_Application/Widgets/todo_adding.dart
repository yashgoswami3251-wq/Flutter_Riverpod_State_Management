import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoAdding extends StatefulWidget {
  const TodoAdding({super.key});

  @override
  State<TodoAdding> createState() => _TodoAddingState();
}

class _TodoAddingState extends State<TodoAdding> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final texttheme = theme.textTheme;
    final colorschema = theme.colorScheme;

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text("New Todo",style: texttheme.bodyLarge,)
          ],
        ),
      ),
    );
  }
}

