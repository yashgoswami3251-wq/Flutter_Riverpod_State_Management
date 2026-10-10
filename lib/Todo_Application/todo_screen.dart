import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management_flutter/Todo_Application/Widgets/overview_card.dart';
import 'package:state_management_flutter/Todo_Application/Widgets/todo_tile.dart';

import 'Widgets/todo_adding.dart';

class todoscreen extends StatefulWidget {
  const todoscreen({super.key});

  @override
  State<todoscreen> createState() => _todoscreenState();
}

class _todoscreenState extends State<todoscreen> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final texttheme = theme.textTheme;
    final colorschema = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              OverviewCard(),

              /// Todo tile
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(itemCount: 5, itemBuilder: (context,index){
                  return TodoTile();
                }),
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context) => TodoAdding());
      },child: Icon(Icons.add),),
    );
  }
}
