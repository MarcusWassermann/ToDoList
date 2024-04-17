import 'package:to_do_app/models/todo.dart';

class TodoRepository {
  final List<Todo> _todos = [
    Todo(title: 'To-Do 1'),
    Todo(title: 'To-Do 2'),
    Todo(title: 'To-Do 3'),
    Todo(title: 'To-Do 4'),
    Todo(title: 'To-Do 5'),
  ];

  List<Todo> getTodos() {
    return List.from(_todos);
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void toggleTodoStatus(int index) {
    _todos[index].toggleStatus();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
  }
}
