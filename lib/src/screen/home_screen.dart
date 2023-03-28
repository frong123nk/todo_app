import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/blocs/todo_bloc.dart';
import 'package:flutter_application_5/src/blocs/todo_event.dart';
import 'package:flutter_application_5/src/model/todo.dart';
import 'package:flutter_application_5/src/screen/add_todo_screen.dart';
import 'package:flutter_application_5/src/screen/post_screen.dart';
import 'package:flutter_application_5/src/widgets/todo_list.dart';
import 'package:flutter_application_5/src/screen/device_id_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TodoBloc _todoBloc;

  @override
  void initState() {
    super.initState();
    _todoBloc = TodoBloc();
    _todoBloc.todoEventSink.add(LoadTodos());
  }

  @override
  void dispose() {
    _todoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
        actions: [
          IconButton(
            icon: Icon(Icons.collections_bookmark_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.device_unknown),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceIdScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _todoBloc.todos,
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return TodoList(todos: snapshot.data!, todoBloc: _todoBloc);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTodoScreen(todoBloc: _todoBloc)),
          );
          _todoBloc.todoEventSink.add(LoadTodos());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
