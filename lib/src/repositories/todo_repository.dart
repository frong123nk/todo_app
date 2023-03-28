import 'package:flutter_application_5/src/model/todo.dart';

class TodoRepository {
  // This is a simple in-memory storage for demonstration purposes.
  // Replace this with actual storage like SQLite, Hive, or a remote API.
  List<Todo> _todos = [];

  Future<List<Todo>> getTodos() async {
    return _todos;
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    int index = _todos.indexWhere((element) => element.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    _todos.removeWhere((element) => element.id == todo.id);
  }
}
