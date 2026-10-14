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
    return  Dialog(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter text...")));
                  }

                  final currenttext = ref.read(textprovider);
                  ref.read(textprovider.notifier).state = [...currenttext,text];

                  Navigator.of(context).pop();

                }, child: Text("Save")),
              ],
            )
          ],
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please update Text")));
                }

                final currenttext = ref.read(textprovider);
                final updatedext =[...currenttext];

                updatedext[widget.index] = newtext;
                ref.read(textprovider.notifier).state = updatedext;

                Navigator.of(context).pop();

              }, child: Text("Update"))
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

    bool isagree = false;

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure to delete this text",style: TextStyle(fontSize: 18),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                isagree = true;
                if(isagree == true){
                  ref.read(textprovider.notifier).state.removeAt(widget.index);
                  ref.read(textprovider.notifier).update((state)=>[...state]);

                  Navigator.of(context).pop();
                }
              }, child: Text("Agree")),
              SizedBox(width: 15,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
                isagree = false;
              }, child: Text("DisAgree"))
            ],
          )
        ],
      ),
    );;
  }
}




