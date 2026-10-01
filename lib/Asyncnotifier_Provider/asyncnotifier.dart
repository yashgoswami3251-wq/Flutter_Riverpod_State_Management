import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_flutter/Future_Provider/fake_api.dart';
import '../Future_Provider/future.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(home: asyncclass(),)));
}

final asyncprovider = AsyncNotifierProvider<asyncnotifier, String>(()=>asyncnotifier());

class asyncnotifier extends AsyncNotifier<String>{
  @override
  FutureOr<String> build() async{
    return await ref.read(apiprovider).fetchGreeting();
  }

  Future<void> refreshGreeting() async {
    try{
      state = AsyncValue.loading();
      final value = await ref.read(apiprovider).fetchGreeting();
      state = AsyncValue.data(value);
    }catch(e){
      state = AsyncError(e, StackTrace.current);
  }
}
}

// UI

class asyncclass  extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final greetingasync = ref.watch(asyncprovider);
    final greetingasyncNotify = ref.watch(asyncprovider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Async Notifier")
      ),
      body: Center(
        child:greetingasync.when(
            skipLoadingOnRefresh: false,
            data: (data) => Text(data,style: TextStyle(fontSize: 23),),
            error: (e,_)=>Text(e.toString(),style: TextStyle(fontSize: 23),),
            loading:() => CircularProgressIndicator()),),
      floatingActionButton: FloatingActionButton(
        onPressed: greetingasyncNotify.refreshGreeting,
        child: Icon(Icons.refresh),),
    );
  }

}


