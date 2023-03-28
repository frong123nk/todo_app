import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/screen/task_list_page.dart';
import 'package:flutter_application_5/src/services/device_id_service.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToTaskListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskListPage(title: 'Task List')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth * 0.9,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo.shade200,
                  Colors.indigo.shade300,
                ],
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Device Information',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 16),
                  FutureBuilder<String>(
                    future: retrieveDeviceId(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'Device ID: ${snapshot.data}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  FutureBuilder<String>(
                    future: getAppVersion(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'App Version: ${snapshot.data}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: navigateToTaskListPage,
                    child: Text('Go to Task List'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
