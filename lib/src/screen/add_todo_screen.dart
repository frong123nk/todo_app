import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/blocs/todo_bloc.dart';
import 'package:flutter_application_5/src/blocs/todo_event.dart';
import 'package:flutter_application_5/src/model/todo.dart';

class AddTodoScreen extends StatefulWidget {
  final TodoBloc todoBloc;

  AddTodoScreen({required this.todoBloc});

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TodoBloc _todoBloc;
  String _title = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _todoBloc = TodoBloc();
  // }

  // @override
  // void dispose() {
  //   _todoBloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final todoBloc = widget.todoBloc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ToDo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _title = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newTodo = Todo(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: _title,
                      completed: false,
                    );
                    widget.todoBloc.todoEventSink.add(AddTodo(
                        newTodo)); // Use widget.todoBloc instead of _todoBloc
                    Navigator.pop(context);
                  }
                },
                child: Text('Add ToDo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
