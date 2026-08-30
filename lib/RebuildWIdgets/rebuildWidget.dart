import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_management_flutter/StaticProvider/static_provider.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(debugShowCheckedModeBanner:false ,home: MyApp())));
}

final counterprovider = StateProvider((Ref ref){
  return 0;
});

class MyApp extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var count = ref.watch(counterprovider);
    print("Build Method Called");
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Counter App")),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Consumer(
            builder: (ctx,provider,_){
              print("Consumer method called");
              final count = provider.watch(counterprovider);
              return Text(count.toString());
            },
      ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(counterprovider.notifier).state++;
        },child: Icon(Icons.add),),
    );
  }
}
