// ignore_for_file: library_private_types_in_public_api

import 'dart:html';

import 'package:flutter/material.dart';

class TodoListApp extends StatefulWidget {
  const TodoListApp({super.key});

  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  List<Map<String, dynamic>> todos = [];
  final TextEditingController _controller = TextEditingController();

  void _toggleTodo(int index) {
    setState(() {
      todos[index]['isDone'] = !todos[index]['isDone'];
    });
  }

  void _addTodo() {
    String newTodoTitle = _controller.text;
    if (newTodoTitle.isNotEmpty) {
      setState(() {
        todos.add({'title': newTodoTitle, 'isDone': false});
        _controller.clear();
      });
    }
  }

  void _removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/6192122.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Neues To-Do eingeben',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _addTodo,
                          icon: const Icon(Icons.add),
                          color: Colors.white, 
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          _removeTodo(index);
                        },
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          color: todos[index]['isDone']
                              ? Colors.grey[300]
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              todos[index]['title'],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: todos[index]['isDone']
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: todos[index]['isDone']
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            leading: Checkbox(
                              value: todos[index]['isDone'],
                              onChanged: (bool? newValue) {
                                _toggleTodo(index);
                              },
                              activeColor: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}