

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/repository/todo_provider.dart.dart';
import 'package:to_do_app/widgets/todo_item.dart';


class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final TodoProvider todoProvider;

  const TodoList({super.key, required this.todos, required this.todoProvider});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  content:
                      Text('Möchtest du "${todo.title}" wirklich löschen?'),
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
                    content: Text('ToDo "${todo.title}" gelöscht.'),
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
    );
  }
}
