import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/repository/todo_provider.dart.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final int index;

  const TodoItem({super.key, required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: todo.isDone ? Colors.grey[300] : Colors.white,
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: todo.isDone ? Colors.grey : Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          todo.isDone
              ? 'Erledigt am: ${DateFormat('dd.MM.yyyy HH:mm').format(todo.completedAt ?? DateTime.now())}'
              : 'Erstellt am: ${DateFormat('dd.MM.yyyy HH:mm').format(todo.createdAt)}',
        ),
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (bool? newValue) {
            Provider.of<TodoProvider>(context, listen: false)
                .toggleTodoStatus(index);
          },
          activeColor: const Color.fromARGB(255, 215, 55, 19),
        ),
      ),
    );
  }
}
