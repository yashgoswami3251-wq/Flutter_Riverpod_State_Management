import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_text.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: practice())));
}

class practice extends ConsumerStatefulWidget {
  const practice({super.key});

  @override
  ConsumerState<practice> createState() => _practiceState();
}

class _practiceState extends ConsumerState<practice> {
  @override
  Widget build(BuildContext context) {

    final text = ref.watch(textprovider);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Practice")),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
          itemCount: text.length,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: Text(text[index])),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=>edittext(
                  index: index,
                  currenttext: text[index].toString(),
                ));
              }, icon: Icon(Icons.edit)),
              SizedBox(width: 20,),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=>deletetext(
                  index: index,
                ));
              },icon: Icon(Icons.delete_outline)),
            ],
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context)=> addingtext());
      },child: Icon(Icons.add),),
    );
  }
}
