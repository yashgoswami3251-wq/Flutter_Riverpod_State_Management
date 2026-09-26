import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(debugShowCheckedModeBanner: false, home: CounterScreen())));
}

final counterProvider = StateNotifierProvider<counternotifier,int>((_){
  return counternotifier(0);
});

class counternotifier extends StateNotifier<int>{
  counternotifier(super.state);
  void increament() => state++;
  void decreament() => state--;
  void reset() => state = 0;
}
// Ui Screen to Display Data
class CounterScreen extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final controll = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("State Notifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
                builder: (ctx,provider,_){
                  final count = provider.watch(counterProvider);
                  return Text("count : $count",style: TextStyle(fontSize: 23),);
                },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: (){
            controll.decreament();
          }, child: Icon(Icons.remove)),
          ElevatedButton(onPressed: (){
            controll.increament();
          }, child: Icon(Icons.add)),
          ElevatedButton(onPressed: (){
            controll.reset();
          }, child: Icon(Icons.refresh))
        ],
      ),
    );
  }

}

