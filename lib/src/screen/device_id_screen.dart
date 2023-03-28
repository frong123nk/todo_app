import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/blocs/appversion_bloc.dart';
import 'package:flutter_application_5/src/blocs/device_bloc.dart';

class DeviceIdScreen extends StatefulWidget {
  @override
  _DeviceIdScreenState createState() => _DeviceIdScreenState();
}

class _DeviceIdScreenState extends State<DeviceIdScreen> {
  late final DeviceBloc _deviceBloc;
  late final appVersionBloc _appVersionBloc;

  @override
  void initState() {
    super.initState();
    _deviceBloc = DeviceBloc();
    _appVersionBloc = appVersionBloc();
  }

  @override
  void dispose() {
    _deviceBloc.dispose();
    _appVersionBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Device ID'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: StreamBuilder<String>(
                stream: _deviceBloc.deviceId,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Device ID: ${snapshot.data}',
                      style: TextStyle(fontSize: 16),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Center(
              child: StreamBuilder<String>(
                stream: _appVersionBloc.appVersion,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Device ID: ${snapshot.data}',
                      style: TextStyle(fontSize: 16),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ));
  }
}
