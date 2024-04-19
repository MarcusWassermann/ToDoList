// todo_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/repository/todo_provider.dart.dart';
import 'todo_input_field.dart';
import 'todo_item.dart';
import 'todo_count_row.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

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
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: TodoInputField(controller: _controller),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Neue ToDo dem Provider hinzugefügt
                            todoProvider.addTodo(Todo(
                              title: _controller.text,
                              isDone: false,
                              createdAt: DateTime.now(),
                              completedAt: null,
                            ));
                            _controller.clear();
                          },
                          icon: const Icon(Icons.add),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TodoItem(todo: todo);
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
