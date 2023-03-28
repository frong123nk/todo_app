import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';

class appVersionBloc {
  final _appVersionStreamController = StreamController<String>();

  Stream<String> get appVersion => _appVersionStreamController.stream;

  appVersionBloc() {
    _getAppVersion();
  }

  // Future<void> _getAppVersion() async {
  //   String deviceId = await _deviceIdRepository.getDeviceId();
  //   _appVersionStreamController.add(deviceId);
  // }

  Future<void> _getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  _appVersionStreamController.sink.add(packageInfo.version);
}

  void dispose() {
    _appVersionStreamController.close();
  }
}
