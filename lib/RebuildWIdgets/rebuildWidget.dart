import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_management_flutter/StaticProvider/static_provider.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: MyApp())));
}


final counterProvider = StateProvider<int>((ref) {
  return 0;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("Build method called");
    return Scaffold(
      appBar: AppBar(
        title: Text("Rebuild Widgets"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.read(counterProvider.notifier).state ++;
          },child: Icon(Icons.add),),
      body: Center(child:
      Consumer(
          builder: (ctx,provider,child){
            final counter = provider.watch(counterProvider);
            print("Consumer Method called");
            return Text("$counter");
      },))
    );
  }
}
