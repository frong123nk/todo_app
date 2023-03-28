import 'package:flutter_application_5/src/model/todo.dart';

abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo(this.todo);
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  DeleteTodo(this.todo);
}
