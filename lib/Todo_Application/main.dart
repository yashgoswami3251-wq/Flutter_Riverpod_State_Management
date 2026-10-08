import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_app.dart';

void main(){
  runApp(ProviderScope(child: MyApp()));
}