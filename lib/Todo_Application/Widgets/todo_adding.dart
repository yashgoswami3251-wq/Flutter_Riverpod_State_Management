import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final addprovider = StateProvider<List<dynamic>>((Ref ref){
  return [];
});

class TodoAdding extends ConsumerStatefulWidget {
  const TodoAdding({super.key});

  @override
  ConsumerState<TodoAdding> createState() => _TodoAddingState();
}

class _TodoAddingState extends ConsumerState<TodoAdding> {
  @override
  Widget build(BuildContext context) {
    final textcontroller = TextEditingController();
    final theme = Theme.of(context);
    final texttheme = theme.textTheme;

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("New Todo",style: texttheme.bodyLarge,),
            SizedBox(height: 20,),
            TextField(
              controller: textcontroller,
              decoration: InputDecoration(
                hintText: "Enter Todo Title"
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("Close",style: TextStyle(color: Colors.white),)),
                ElevatedButton(
                    onPressed: (){
                      final title = textcontroller.text;
                      if(title.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter title")));
                        return;
                      }

                      final currenttodos = ref.read(addprovider);
                      ref.read(addprovider.notifier).state = [...currenttodos,title];
                      
                      Navigator.of(context).pop();

                }, child: Text("Save",style: TextStyle(color: Colors.white),))
              ],
            )
          ],
        ),
      ),
    );
  }
}

