import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/blocs/todo_bloc.dart';
import 'package:flutter_application_5/src/blocs/todo_event.dart';
import 'package:flutter_application_5/src/model/todo.dart';
import 'package:flutter_application_5/src/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final TodoBloc todoBloc;

  TodoList({required this.todos, required this.todoBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onCheckboxChanged: (bool? value) {
            todoBloc.todoEventSink.add(
              UpdateTodo(todo.copyWith(completed: value)),
            );
          },
          onDelete: () {
            todoBloc.todoEventSink.add(DeleteTodo(todo));
          },
        );
      },
    );
  }
}