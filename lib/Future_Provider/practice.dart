import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(){
  runApp(ProviderScope(child: futurepro()));
}

Future<List<String>> fetchUsers() async {

  await Future.delayed(
    const Duration(seconds: 2),
  );

  return [
    "Yash",
    "Marmik",
    "Pritesh",
  ];
  
}

final nameprovider = Provider((_)=>fetchUsers());

final futurenameprovider = FutureProvider((Ref ref) async {
  return await ref.read(nameprovider);
});


class futurepro extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(futurenameprovider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Future Provider"),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: names.when(
              data: (greeting)=>Text(greeting.toString(),style: TextStyle(fontSize: 23),),
              error: (error,stacktrace)=>Text(error.toString()),
              loading: ()=>CircularProgressIndicator()),
        )
      ),
    );
  }

}

/*
AsyncValue represents three possible states:

FutureProvider
|
┌─────┼─────┐
↓     ↓     ↓
Loading Data  Error
*/
