class Todo {
  final String title;
  bool isDone;
  DateTime createdAt; // Erstellungsdatum
  DateTime? completedAt; // Erledigungsdatum

  Todo({
    required this.title,
    this.isDone = false,
    required this.createdAt,
    this.completedAt, // Erledigungsdatum
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt
          ?.toIso8601String(), //  Erledigungsdatums, falls vorhanden
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      isDone: json['isDone'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null, // Erledigungsdatum, falls vorhanden
    );
  }
}
