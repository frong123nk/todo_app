import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onDelete;

  TodoItem({
    required this.todo,
    required this.onCheckboxChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          onChanged: onCheckboxChanged,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
