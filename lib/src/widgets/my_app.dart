import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/screen/home_page.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device ID Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Device ID Example'),
    );
  }
}
