import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: consumerstatefull())));
}

class consumerstatefull extends ConsumerStatefulWidget {
  const consumerstatefull({super.key});

  @override
  ConsumerState<consumerstatefull> createState() => _consumerstatefullState();
}

final textprovider = StateProvider((Ref ref){
  return '';
});

final secondprovider = StateProvider((Ref ref){
  return '';
});

class _consumerstatefullState extends ConsumerState<consumerstatefull> {

  late final TextEditingController _namecontroller;
  late final TextEditingController _emailcontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller = TextEditingController();
    _namecontroller.addListener((){
      ref.read(textprovider.notifier).state = _namecontroller.text;
    });

    _emailcontroller = TextEditingController();
    _emailcontroller.addListener((){
      ref.read(secondprovider.notifier).state = _emailcontroller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final text = ref.watch(textprovider)
    print("Build method called");
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("TextField")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _namecontroller,
              ),
            ),
            SizedBox(height: 10,),
            Consumer(
                builder: (ctx,provider,_){
                  final text = provider.watch(textprovider);
                  print("Consumer Method called");
                  return Text("Type Name...$text",style: TextStyle(fontSize: 23),);
                },
            ),
            
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _emailcontroller,
                )
            ),
            SizedBox(height: 10,),
            Consumer(
                builder: (ctx,provider,_){
                  final email = provider.watch(secondprovider);
                  return Text("Type Email...$email",style: TextStyle(fontSize: 23),);
                },
            )
          ],
        ),
      ),
    );
  }
}
