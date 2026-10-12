import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_adding.dart';

class TodoTile extends ConsumerWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(addprovider);
    final texttheme = Theme.of(context).textTheme;

    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos added yet'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (_){}),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    todos[index],
                    style: texttheme.bodyMedium,
                  ),
                ),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context)=>edittodo(
                    index: index,
                    currenttext: todos[index].toString(),
                  ));
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){},icon: Icon(Icons.delete_outline),)
              ],
            ),
          ),
        );
      },
    );
  }
}
