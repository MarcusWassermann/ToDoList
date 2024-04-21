// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/repository/todo_provider.dart.dart';
import 'package:to_do_app/widgets/todo_count_row.dart';
import 'package:to_do_app/widgets/todo_input_field.dart';
import 'package:to_do_app/widgets/todo_list.dart';


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
          int openTodosCount = todoProvider.openTodosCount;
          int completedTodosCount = todoProvider.completedTodosCount;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TodoInputField(controller: _controller),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_controller.text.trim().isNotEmpty) {
                              // Check if text is not empty
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
                  ),
                  TodoCountRow(
                    openTodosCount: openTodosCount,
                    completedTodosCount: completedTodosCount,
                  ),
                  TodoList(todos: todos, todoProvider: todoProvider),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
