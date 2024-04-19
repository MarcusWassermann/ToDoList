// todo_input_field.dart
import 'package:flutter/material.dart';

class TodoInputField extends StatelessWidget {
  final TextEditingController controller;

  const TodoInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Neues To-Do eingeben',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
