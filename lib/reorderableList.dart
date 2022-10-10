import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  List<int> items = List<int>.generate(5, (int index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  _updateMyItems(oldIndex, newIndex);
                });
              },
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: ValueKey(items[index]),
                  onDismissed: (direction) {
                    setState(() {
                      items.remove(items[index]);
                    });
                  },
                  child: ListTile(
                    title: Center(
                      child: Text(
                        items[index].toString(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 300, bottom: 100),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: TextField(controller: myController),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (!items.contains(int.parse(myController.text)))
                            items.add(int.parse(myController.text));
                          else
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Number is busy!'),
                              ),
                            );
                          myController.clear();
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Text('Add'),
                      )
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _updateMyItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final int item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }
}
