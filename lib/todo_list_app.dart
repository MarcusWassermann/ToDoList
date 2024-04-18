import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/repository/todo_provider.dart.dart';
import 'package:to_do_app/todo_list_screen.dart.dart';


class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: const MaterialApp(
        home: TodoListScreen(),
      ),
    );
  }
}
