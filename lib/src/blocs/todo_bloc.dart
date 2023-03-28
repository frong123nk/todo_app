import 'dart:async';
import 'package:flutter_application_5/src/blocs/todo_event.dart';
import 'package:flutter_application_5/src/model/todo.dart';
import 'package:flutter_application_5/src/repositories/todo_repository.dart';

class TodoBloc {
  final TodoRepository _todoRepository = TodoRepository();
  final _todosStreamController = StreamController<List<Todo>>();

  Stream<List<Todo>> get todos => _todosStreamController.stream;

  final _todoEventController = StreamController<TodoEvent>();

  Sink<TodoEvent> get todoEventSink => _todoEventController.sink;

  TodoBloc() {
    _todoEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TodoEvent event) async {
    if (event is LoadTodos) {
      List<Todo> todos = await _todoRepository.getTodos();
      _todosStreamController.add(todos);
    } else if (event is AddTodo) {
      await _todoRepository.addTodo(event.todo);
      _mapEventToState(LoadTodos());
    } else if (event is UpdateTodo) {
      await _todoRepository.updateTodo(event.todo);
      _mapEventToState(LoadTodos());
    } else if (event is DeleteTodo) {
      await _todoRepository.deleteTodo(event.todo);
      _mapEventToState(LoadTodos());
    }
  }

  void dispose() {
    _todosStreamController.close();
    _todoEventController.close();
  }
}
