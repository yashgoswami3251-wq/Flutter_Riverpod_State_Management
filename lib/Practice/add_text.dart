import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class addingtext extends ConsumerStatefulWidget {
  const addingtext({super.key});

  @override
  ConsumerState<addingtext> createState() => _addingtextState();
}

final textprovider = StateProvider<List<dynamic>>((Ref ref){
  return [];
});

class _addingtextState extends ConsumerState<addingtext> {
  @override
  Widget build(BuildContext context) {
    final textcontroller = TextEditingController();
    return Scaffold(
      body: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textcontroller,
              decoration: InputDecoration(
                hintText: "Enter Text",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            Row(
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("Close")),
                TextButton(onPressed: (){
                  final text = textcontroller.text;
                  if(text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please filled this field")));
                  }

                  final cureenttext = ref.watch(textprovider);
                  ref.read(textprovider.notifier).state = [...cureenttext,text];
                  Navigator.of(context).pop();
                }, child: Text("Save")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class edittext extends ConsumerStatefulWidget{
  const edittext({super.key , required this.index, required this.currenttext});

  final int index;
  final String currenttext;

  @override
  ConsumerState<edittext> createState() => _edittextState();
}

class _edittextState extends ConsumerState<edittext> {

  final textcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    textcontroller.text = widget.currenttext;
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              hintText: "Enter new Text",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel")),
              ElevatedButton(onPressed: (){
                final newtext = textcontroller.text.trim();

                if(newtext.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter new Value")));
                }

                final currenttext = ref.read(textprovider);
                final updatedtext = [...currenttext];

                updatedtext[widget.index] = newtext;
                ref.read(textprovider.notifier).state = updatedtext;

                Navigator.of(context).pop();

              }, child: Text("Update"))
            ],
          )
        ],
      ),
    );
  }
}


