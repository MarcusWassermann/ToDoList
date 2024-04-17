

class Todo {
  final String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });

  void toggleStatus() {
    isDone = !isDone;
  }
}
