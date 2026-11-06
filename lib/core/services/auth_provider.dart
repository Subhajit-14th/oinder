import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final deviceId = await ref.read(deviceIdProvider.future);
    final token = await AuthStorage.getToken(deviceId);

    return token != null && token.isNotEmpty;
  }

  Future<void> login(String token) async {
    final deviceId = await ref.read(deviceIdProvider.future);

    await AuthStorage.saveToken(deviceId: deviceId, token: token);

    state = const AsyncData(true);
  }

  Future<void> logout() async {
    final deviceId = await ref.read(deviceIdProvider.future);

    await AuthStorage.clearToken(deviceId);

    state = const AsyncData(false);
  }

  Future<void> refreshAuth() async {
    final deviceId = await ref.read(deviceIdProvider.future);
    final token = await AuthStorage.getToken(deviceId);

    state = AsyncData(token != null && token.isNotEmpty);
  }
}
