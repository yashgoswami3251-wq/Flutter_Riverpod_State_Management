import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


final taskprovider = StateProvider<List<dynamic>>((Ref ref){
  return [];
});


class Addtask extends ConsumerStatefulWidget {
  const Addtask({super.key});

  @override
  ConsumerState<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends ConsumerState<Addtask> {
  @override
  Widget build(BuildContext context) {

    final taskcontroller = TextEditingController();

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Add New Task",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          TextFormField(
            controller: taskcontroller,
            decoration: InputDecoration(
              label: Text("Task Title"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel Task")),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                final task = taskcontroller.text;
                if(task.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter Task")));
                }

                final currenttask = ref.read(taskprovider);
                ref.read(taskprovider.notifier).state = [task,...currenttask];

                Navigator.of(context).pop();

              }, child: Text("Add Task"))
            ],
          )
        ],
      ),
    );
  }
}


class deletetext extends ConsumerStatefulWidget {
  final int index;
  const deletetext({super.key, required this.index});

  @override
  ConsumerState<deletetext> createState() => _deletetextState();
}

class _deletetextState extends ConsumerState<deletetext> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure to delete this font",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel")),

              ElevatedButton(onPressed: (){
                ref.read(taskprovider.notifier).state.removeAt(widget.index);
                ref.read(taskprovider.notifier).update((state)=>[...state]);

                Navigator.of(context).pop();
              }, child: Text("Delete"))
            ],
          )
        ],
      ),
    );
  }
}

class edittext extends ConsumerStatefulWidget {

  final int index;
  final String currenttext;

  const edittext({super.key, required this.index , required this.currenttext});

  @override
  ConsumerState<edittext> createState() => _edittextState();
}

class _edittextState extends ConsumerState<edittext> {

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
              hintText: "New Text",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel")),
              ElevatedButton(onPressed: (){

                final newtext = textcontroller.text.trim();
                if(newtext.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter new text")));
                  Navigator.of(context).pop();
                }

                final currenttext = ref.read(taskprovider);
                final updatedtext = [...currenttext];

                updatedtext[widget.index] = newtext;
                ref.read(taskprovider.notifier).state = updatedtext;

                Navigator.of(context).pop();

              }, child: Text("Update")),
            ],
          )
        ],
      ),
    );
  }
}


