import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final texttheme = theme.textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: Row(
            children: [
              Checkbox(
                  shape: CircleBorder(),
                  value: false, onChanged: (_){}),
              Expanded(
                child: Text("Task",style: texttheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.none
                )),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline)),
            ],
          ),
        )
      ),
    );
  }
}
