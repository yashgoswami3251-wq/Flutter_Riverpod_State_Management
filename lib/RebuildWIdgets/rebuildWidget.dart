import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child:  MaterialApp(home: rebuildwidget())));
}

final counterProvider = StateProvider((Ref ref){
  return 0;
});

class rebuildwidget extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final counter = ref.watch(counterProvider);
    print("Build method called");
    return Scaffold(
      appBar: AppBar(
        title: Text("Rebuild Widget"),
        backgroundColor: Colors.indigo,
      ),
      body:Center(
        child: Consumer(
          builder: (ctx,provider,_){
            print("Consumer method called");
            final count = provider.watch(counterProvider);
            return Text(count.toString());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(counterProvider.notifier).state++;
        },child: Icon(Icons.add),),
    );
  }
}
