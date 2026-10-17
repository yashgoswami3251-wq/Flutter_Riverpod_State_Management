import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_flutter/Student_Task_Manager/riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homepage(),
      ),
    ),
  );
}

class homepage extends ConsumerStatefulWidget {
  const homepage({super.key});

  @override
  ConsumerState<homepage> createState() => _homepageState();
}

class _homepageState extends ConsumerState<homepage> {
  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskprovider);
    final search = ref.watch(searchqueryprovider);

    final filteredtask = task.where((task) {
      return task.toLowerCase().contains(
        search.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Student Task Manager",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer(
              builder: (ctx,reference,_){
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Total Task",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                          Text(
                            reference.watch(taskprovider).length.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 29),
                      Column(
                        children: [
                          const Text(
                            "Completed",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                          Text(
                            reference.watch(taskprovider).length.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Search TextField
            TextField(
              onChanged: (value) {
                ref.read(searchqueryprovider.notifier).state = value;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search tasks...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Display filtered tasks
            Expanded(
              child: ListView.builder(
                itemCount: filteredtask.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (_) {},
                              ),

                              SizedBox(
                                  width: 170,
                                  child: Text(filteredtask[index], softWrap: true,)),
                            ],
                          ),

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => edittext(
                                      index: index,
                                      currenttext: task[index],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),

                              IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) => deletetext(
                                      index: index,
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Addtask(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
