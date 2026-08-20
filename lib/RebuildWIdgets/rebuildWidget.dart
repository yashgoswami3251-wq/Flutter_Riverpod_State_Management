import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_management_flutter/StaticProvider/static_provider.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: MyApp())));
}


final counterProvider = StateProvider((Ref ref){
  return 0;
});

class MyApp extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rebuild Widgets"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){

          },child: Icon(Icons.add),),
    );

  }

}
