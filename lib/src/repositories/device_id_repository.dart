import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceIdRepository {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String> getDeviceId() async {
    String? deviceId = await _secureStorage.read(key: 'device_id');

    if (deviceId == null) {
      deviceId = await _fetchDeviceId();
      await _secureStorage.write(key: 'device_id', value: deviceId);
    }

    return deviceId;
  }

  Future<String> _fetchDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var deviceId;

    if (Platform.isAndroid) {
      const _androidIdPlugin = AndroidId();
      String androidId;
      try {
        androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
      } catch (error) {
        androidId = 'Failed to get Android ID.';
      }
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    } else {
      throw UnsupportedError('This platform is not supported.');
    }

    return deviceId;
  }
}
