import 'dart:async';
import 'package:flutter_application_5/src/repositories/device_id_repository.dart';

class DeviceBloc {
  final _deviceIdStreamController = StreamController<String>();
  final _deviceIdRepository = DeviceIdRepository();

  Stream<String> get deviceId => _deviceIdStreamController.stream;

  DeviceBloc() {
    _getDeviceId();
  }

  Future<void> _getDeviceId() async {
    String deviceId = await _deviceIdRepository.getDeviceId();
    _deviceIdStreamController.add(deviceId);
  }

  void dispose() {
    _deviceIdStreamController.close();
  }
}
