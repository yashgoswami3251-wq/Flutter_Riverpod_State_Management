import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(debugShowCheckedModeBanner:false, home: counterscreen())));
}

final numberprovider = StateProvider<List<int>>((_) =>[1,2,3,4,5]);

final sumprovider = Provider((Ref ref){
  final list = ref.watch(numberprovider);
  return list.fold(0, (total , n) => total + n);
});

class counterscreen extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sum = ref.watch(sumprovider);
   return Scaffold(
     appBar: AppBar(
       title: Text("Derived State"),
     ),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("Total Sum : $sum",style: TextStyle(fontSize: 23),)
         ],
       ),
     ),
     floatingActionButton: FloatingActionButton(onPressed: (){
       final list = ref.read(numberprovider.notifier).state;
       ref.read(numberprovider.notifier).state = [...list,list.length+1];
     },child: Icon(Icons.add),),
   );
  }

}