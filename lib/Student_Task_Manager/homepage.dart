import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_flutter/Student_Task_Manager/riverpod.dart';

void main(){
  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homepage()),
  ));
}

class homepage extends ConsumerStatefulWidget {
  const homepage({super.key});

  @override
  ConsumerState<homepage> createState() => _homepageState();
}

class _homepageState extends ConsumerState<homepage> {
  @override
  Widget build(BuildContext context) {

    final task = ref.watch(taskprovider);
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Student Task Manager",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),),
                  Icon(Icons.settings,color: Colors.white,),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Total Task",style: TextStyle(fontSize: 18),),
                      Text(task.length.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(width: 29,),
                  Column(
                    children: [
                      Text("Comleted",style: TextStyle(fontSize: 18),),
                      Text("3",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search tasks...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: ListView.builder(
                itemCount: task.length,
                  itemBuilder: (context,index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (_){}),
                            Text(task[index]),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              showDialog(context: context, builder: (context)=>edittext(
                                index: index,
                                currenttext: task[index],
                              ));
                            }, icon: Icon(Icons.edit)),

                            IconButton(onPressed: (){
                              showDialog(context: context, builder: (context)=>deletetext(
                                index: index,
                              ));
                            }, icon: Icon(Icons.delete_outline))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context)=>Addtask());
      },child: Icon(Icons.add),),
    );
  }
}
