import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/todo.dart';

class TodoRepository {
  late SharedPreferences _prefs;

  TodoRepository() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<Todo> getTodos() {
    final List<String>? todoList = _prefs.getStringList('todos');
    if (todoList == null) {
      return [];
    } else {
      return todoList
          .map((jsonString) => Todo.fromJson(jsonDecode(jsonString)))
          .toList();
    }
  }

  Future<void> addTodo(Todo todo) async {
    final List<Todo> todos = getTodos();
    todos.add(todo);
    await _saveTodos(todos);
  }

  Future<void> removeTodoAtIndex(int index) async {
    final List<Todo> todos = getTodos();
    todos.removeAt(index);
    await _saveTodos(todos);
  }

  Future<void> updateTodoAtIndex(int index, Todo updatedTodo) async {
    final List<Todo> todos = getTodos();
    todos[index] = updatedTodo;
    await _saveTodos(todos);
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    final List<String> jsonList =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await _prefs.setStringList('todos', jsonList);
  }
}
