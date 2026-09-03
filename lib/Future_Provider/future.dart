import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_flutter/Future_Provider/fake_api.dart';

void main(){
  runApp(ProviderScope(child: futureprovider()));
}

final apiprovider = Provider((_) => Fakeservice());

final greetingFutureprovider= FutureProvider((Ref ref) async{
  final service = ref.read(apiprovider);
  return await service.fetchGreeting();
});


class futureprovider extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final GreetingAsync = ref.watch(greetingFutureprovider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Async Greeting"),
        ),
        body: Center(
          child: GreetingAsync.when(
            skipLoadingOnRefresh: false,
            // API successfully returned data
              data: (greeting) => Text(greeting,style: TextStyle(fontSize: 24),),

            // API failed
              error: (error , stackTrace) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error $error',style: TextStyle(fontSize: 24,color: Colors.red),),
                  SizedBox(height: 12,),
                  ElevatedButton(onPressed: (){
                    /// Runs the provider again
                    ref.refresh(greetingFutureprovider);
                  }, child: Text("Retry"))
                ],
              ),

            // API is running
              loading: () => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

}


/// FutureProvider → API call → Loading → Data OR Error → Retry if needed.