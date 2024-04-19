import 'package:flutter/material.dart';

class TodoInputField extends StatelessWidget {
  final TextEditingController controller;

  const TodoInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Neues To-Do eingeben',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
