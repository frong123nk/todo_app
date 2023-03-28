import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getDeviceId() async {
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

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<void> storeDeviceId(String deviceId) async {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.write(key: 'device_id', value: deviceId);
}

Future<String> retrieveDeviceId() async {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String? deviceId = await storage.read(key: 'device_id');
  return deviceId ??
      'No device ID found'; // Provide a default value if deviceId is null
}
