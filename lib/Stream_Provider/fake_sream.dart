
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Timerseviceprovider = Provider((_)=>Timerservice());

class Timerservice{
/*
  Stream<int> tick(){
    return Stream.periodic(Duration(seconds: 1),(count)=>count);
  }*/

  Stream<int> tickwitherror() async* {
    for(int i=0; i<=5; i++){
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
    throw Exception("Timer Stoped unexpectedly");
  }
}