import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(){
  runApp(ProviderScope(child: stream()));
}

final tickerprovider = StreamProvider((_){
  return Stream.periodic(Duration(seconds: 1),(count) =>count);
});

/*final tickerwitherror = StreamProvider((Ref ref){
  final service = ref.read(Timerseviceprovider);
  return service.tickwitherror();
});*/


class stream extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final result = ref.watch(tickerprovider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stream Provider"),
        ),
        body: Center(
          child: result.when(
            skipLoadingOnRefresh: false,
              data: (data)=>Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Count value is : $data"),
                    ElevatedButton(onPressed: (){
                      return ref.refresh(tickerprovider);
                    }, child: Text("Refresh"))
                  ],
              ),
              error: (e,_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error : $e"),
                    ElevatedButton(
                        onPressed: (){
                          return ref.refresh(tickerprovider);
                    }, child: Text("Retry"))
                  ],
              ),
              loading: () => CircularProgressIndicator()),
        ),
      ),
    );
  }
}