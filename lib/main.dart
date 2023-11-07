import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Todos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final enterTodo = TextEditingController();
  final editTodo = TextEditingController();
  List<String> todos = ['Buy milk', 'Buy eggs', 'Buy bread'];

    void _removeTodo(int index) {
    final indexTodo = index;
    setState(() {
          todos.removeAt(indexTodo);
        });
  }

  void _editTodo(int index, String text) {
    final indexTodo = index;
    setState(() {
      todos[indexTodo] = text;
    });
  }

  void _addTodo() {
    final text = enterTodo.text;
    setState(() {
      todos.add(text);
    });
    enterTodo.clear();
  }



 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
       Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: enterTodo,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a Todo',
                ),
              ),
              ),
            Expanded(
              child: ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
          return _slideableActions(index);
      },
    )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Slidable _slideableActions(int index) {
    return Slidable(
            // Specify a key if the Slidable is dismissible.
            key: const ValueKey(0),
              // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                 SlidableAction(
          onPressed: (BuildContext context){
            editTodo.text = todos[index];
            showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                controller: editTodo,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit the Todo',
                ),
              ),
                    const SizedBox(height: 1),
                    TextButton(
                      onPressed: () {
                         _editTodo(index, editTodo.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Item changed'),
                                      ),
                                    );
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ),
  );
                                },
                  backgroundColor: Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (BuildContext context){
                                  _removeTodo(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Item deleted'),
                                      ),
                                    );
                                },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: ListTile(title: Text(todos[index])),
          );
  }
}

