// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/repository/todo_provider.dart.dart';
import 'package:to_do_app/widgets/todo_count_row.dart';
import 'package:to_do_app/widgets/todo_input_field.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          List<Todo> todos = todoProvider.todos;
          int openTodosCount = todoProvider.openTodosCount ?? 0;
          int completedTodosCount = todoProvider.completedTodosCount ?? 0;
          return Stack(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TodoInputField(controller: _controller),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            todoProvider.addTodo(Todo(
                              title: _controller.text,
                              isDone: false,
                              createdAt: DateTime.now(),
                              completedAt: null,
                            ));
                            _controller.clear();
                          }
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return ListTile(
                          title: TodoItem(todo: todo, index: index),
                          onTap: () async {
                            bool delete = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('ToDo löschen?'),
                                content: Text(
                                    'Möchtest du "${todo.title}" wirklich löschen?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text('Abbrechen'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text('Löschen'),
                                  ),
                                ],
                              ),
                            );

                            if (delete == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('ToDo "${todo.title}" gelöscht.'),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Rückgängig',
                                    onPressed: () {
                                      todoProvider.addTodo(todo);
                                    },
                                  ),
                                ),
                              );
                              todoProvider.removeTodoAtIndex(index);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  TodoCountRow(
                    openTodosCount: openTodosCount,
                    completedTodosCount: completedTodosCount,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
