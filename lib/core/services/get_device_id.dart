import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class GetDeviceId {
  GetDeviceId._();

  static const _storage = FlutterSecureStorage();
  static const _deviceIdKey = 'device_id';

  static Future<String> getDeviceId() async {
    final storedId = await _storage.read(key: _deviceIdKey);
    if (storedId != null && storedId.isNotEmpty) {
      return storedId;
    }

    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    deviceId ??= const Uuid().v4();

    await _storage.write(key: _deviceIdKey, value: deviceId);

    return deviceId;
  }
}

final deviceIdProvider = FutureProvider<String>((ref) async {
  return GetDeviceId.getDeviceId();
});
