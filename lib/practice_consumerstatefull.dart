import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: consumerstatefulwidget())));
}

var consumerstate = StateProvider((Ref ref){
  return "";
});


class consumerstatefulwidget extends ConsumerStatefulWidget {
  const consumerstatefulwidget({super.key});
  @override
  ConsumerState<consumerstatefulwidget> createState() => _consumerstatefulwidgetState();
}

class _consumerstatefulwidgetState extends ConsumerState<consumerstatefulwidget> {

  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.addListener((){
      ref.read(consumerstate.notifier).state = _controller.text;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    var text = ref.watch(consumerstate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumer Statefull widget"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  label: Text("Enter Text"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11)
                  )
                ),
              ),
            ),
            Text("You Typed : $text")
          ],
        ),
      ),
    );
  }
}
