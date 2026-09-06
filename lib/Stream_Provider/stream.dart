import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fake_sream.dart';

void main(){
  runApp(ProviderScope(child: stream()));
}

/*final tickerprovider = StreamProvider((_){
  return Stream.periodic(Duration(seconds: 1),(count) =>count);
});*/

final tickerwitherror = StreamProvider((Ref ref){
  final service = ref.read(Timerseviceprovider);
  return service.tickwitherror();
});


class stream extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final result = ref.watch(tickerwitherror);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stream Provider"),
        ),
        body: Center(
          child: result.when(
            skipLoadingOnRefresh: false,
              data: (data)=>Text("Count value is : $data"),
              error: (e,_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error : $e"),
                    ElevatedButton(
                        onPressed: (){
                          return ref.refresh(tickerwitherror);
                    }, child: Text("Retry"))
                  ],
              ),
              loading: () => CircularProgressIndicator()),
        ),
      ),
    );
  }
  
}