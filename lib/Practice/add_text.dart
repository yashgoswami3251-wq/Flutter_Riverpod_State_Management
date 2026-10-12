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
