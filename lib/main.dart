import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // ProviderScope is handle all Provider Scope
      ProviderScope(child: MaterialApp(home: const MyApp()))
  );
}


final staticprovider = Provider((Ref ref){
  return "Hello yash";
});

final intprovider = Provider((Ref ref){
  return 03;
});

final doubleprovider = Provider((Ref ref){
  return 76.77;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(staticprovider);
    final intresult = ref.watch(intprovider);
    final doubleresult = ref.watch(doubleprovider);

    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result),
            Text("$intresult"),
            Text("$doubleresult"),
          ],
        ),
      ),
    );
  }
}

