import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];
  late SharedPreferences _prefs;
  final TextEditingController controller = TextEditingController();

  List<Todo> get todos => _todos;

  int get openTodosCount => _todos.where((todo) => !todo.isDone).length;

  int get completedTodosCount => _todos.where((todo) => todo.isDone).length;

  TodoProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<String>? todoList = _prefs.getStringList('todos');
    if (todoList != null) {
      _todos.addAll(
          todoList.map((jsonString) => Todo.fromJson(jsonDecode(jsonString))));
      notifyListeners();
    }
  }

  Future<void> _saveTodos() async {
    final List<String> jsonList =
        _todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await _prefs.setStringList('todos', jsonList);
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    _saveTodos();
    notifyListeners();
    controller.clear();
  }

  void removeTodoAtIndex(int index) {
    _todos.removeAt(index);
    _saveTodos();
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    _saveTodos();
    notifyListeners();
  }
}
