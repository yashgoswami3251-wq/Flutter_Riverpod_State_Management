import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: counterscreen(),)));
}

final counterPro = StateNotifierProvider<statenotify, int>((_){
  return statenotify(0);
});

class statenotify extends StateNotifier<int>{
  statenotify(super.state);

  void incre() => state++;
  void decre() => state--;
  void res() => state = 0;

}

class counterscreen extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final count = ref.watch(counterPro);
    final ctrl = ref.read(counterPro.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("State Notifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("count : $count",style: TextStyle(fontSize: 23),),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: () => ctrl.incre(), child: Icon(Icons.add)),
          ElevatedButton(onPressed: () => ctrl.decre(), child: Icon(Icons.remove)),
          ElevatedButton(onPressed: () => ctrl.res(), child: Icon(Icons.refresh)),
        ],
      ),
    );
  }

}