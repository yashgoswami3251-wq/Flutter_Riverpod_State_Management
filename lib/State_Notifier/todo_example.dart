import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: TodoScreen())));
}


class Todo{
  final int id;
  final String title;
  final bool completed;

  Todo({required this.id, required this.title, required this.completed});

  Todo copyWith({int? id , String? title, bool? completed}){
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed
    );
  }
}

// Provider

final todoprovider = StateNotifierProvider<TodoListnotifier, List<Todo>>(
        (ref) => TodoListnotifier([]),
);


// State Notifier

class TodoListnotifier extends StateNotifier<List<Todo>>{
  TodoListnotifier(super.state);

  void add(String title) {
    final newTodo = Todo(
      id: state.isEmpty ? 0 : state.last.id + 1,
      title: title,
      completed: false,
    );

    state = [...state, newTodo];
  }

  void remove(int id) {
    state = state.where((t) => t.id != id).toList();
  }

  void toggle(int id) {
    final todos = [...state];

    final index = todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final todo = todos[index];
    todos[index] = todo.copyWith(completed: !todo.completed);

    state = todos;
  }
}

// UI

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {

  final controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final todos = ref.watch(todoprovider);
    final notifier = ref.read(todoprovider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Screen"),
      ),
      body: Padding(
          padding: EdgeInsets.all(11),

        child: Column(
          children: [

            // Add Todo
            Row(
              children: [
                Expanded(
                  child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'New Task'
                  ),
                ),
                ),
                IconButton(
                    onPressed: (){
                      final text = controller.text.trim();
                      if(text.isNotEmpty){
                        notifier.add(text);
                        controller.clear();
                      }
                      }, icon: Icon(Icons.add))
              ],
            ),
            SizedBox(height: 10,),

            //List Todos

            Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                    itemBuilder: (_,i){
                    final todo = todos[i];
                    return ListTile(
                      leading: Checkbox(
                          value: todo.completed,
                          onChanged: (_) => notifier.toggle(todo.id)),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),

                      trailing: IconButton(onPressed: (){
                          notifier.remove(todo.id);
                      }, icon: Icon(Icons.delete)),
                    );
                    }))
          ],
        ),
      ),
    );
  }
}
