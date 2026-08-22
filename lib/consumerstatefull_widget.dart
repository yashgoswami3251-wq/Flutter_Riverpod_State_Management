import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(
      ProviderScope(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: consumerstatefullwidget()
          )
      )
  );
}

// ConsumerWiget = you don't need to statefull widget method then use Consumer Widget
// ConsumerStatefullWidget = you need to Statefull widget method like initState() , Setstate(),

final textprovider = StateProvider((Ref ref){
  return "";
});


class consumerstatefullwidget extends ConsumerStatefulWidget {
  const consumerstatefullwidget({super.key});
  @override
  ConsumerState<consumerstatefullwidget> createState() => _consumerstatefullwidgetState();
}

class _consumerstatefullwidgetState extends ConsumerState<consumerstatefullwidget> {

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // "Whenever something changes in this controller, run this function."
    _controller.addListener((){
      ref.watch(textprovider.notifier).state = _controller.text;
    });
  }

  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build Method called");
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("TextForm")),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  label: Text("Write Text"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11)
                  )
                ),
              ),
              SizedBox(height: 10,),
              Consumer(
                  builder: (ctx,provider,child){
                    var text = provider.watch(textprovider);
                    print("Consumer method Called");
                    return Text("You Typed : $text",style: TextStyle(fontSize: 23),);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
