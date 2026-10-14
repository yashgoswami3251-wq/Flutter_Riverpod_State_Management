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
                        return Navigator.of(context).pop();
                      }

                      final currenttodos = ref.read(addprovider);
                      ref.read(addprovider.notifier).state = [title,...currenttodos];
                      
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

class edittodo extends ConsumerStatefulWidget {

  final int index;
  final String currenttext;

  edittodo({super.key, required this.index, required this.currenttext});

  @override
  ConsumerState<edittodo> createState() => _edittodoState();
}

class _edittodoState extends ConsumerState<edittodo> {

  final textcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textcontroller.text = widget.currenttext;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textcontroller,
            decoration: InputDecoration(
              hintText: "Update Text",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel",style: TextStyle(color: Colors.white),)),
              ElevatedButton(
                  onPressed: (){
                    final newtext = textcontroller.text.trim();

                    if(newtext.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter New value")));
                    }

                    final currenttext = ref.read(addprovider);
                    final updatedtext = [...currenttext];

                    updatedtext[widget.index] = newtext;
                    ref.read(addprovider.notifier).state = updatedtext;

                    Navigator.of(context).pop();

              }, child: Text("Update",style: TextStyle(color: Colors.white),)),
            ],
          )
        ],
      ),
    );
  }
}


class deletetodo extends ConsumerStatefulWidget {

  final int index;
  const deletetodo({super.key, required this.index});

  @override
  ConsumerState<deletetodo> createState() => _deletetodoState();
}

class _deletetodoState extends ConsumerState<deletetodo> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure to delete this todos",style: TextStyle(fontSize: 18),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                ref.read(addprovider.notifier).state.removeAt(widget.index);
                ref.read(addprovider.notifier).update((state)=>[...state]);
                Navigator.of(context).pop();
              }, child: Text("Agree",style: TextStyle(color: Colors.white),)),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("DisAgree",style: TextStyle(color: Colors.white),)),
            ],
          )
        ],
      ),
    );
  }
}
