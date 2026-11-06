import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  AuthStorage._();

  static const _storage = FlutterSecureStorage();

  static String _tokenKey(String deviceId) => 'bearer_token_$deviceId';

  // CometChat Keys
  static String _cometChatUidKey(String deviceId) => 'cometchat_uid_$deviceId';

  static String _cometChatAuthTokenKey(String deviceId) =>
      'cometchat_auth_token_$deviceId';

  static String _cometChatUserCreatedKey(String deviceId) =>
      'cometchat_user_created_$deviceId';

  /// Save Bearer Token
  static Future<void> saveToken({
    required String deviceId,
    required String token,
  }) async {
    await _storage.write(key: _tokenKey(deviceId), value: token);
  }

  /// Read Bearer Token
  static Future<String?> getToken(String deviceId) async {
    return _storage.read(key: _tokenKey(deviceId));
  }

  /// Clear Token (Logout)
  static Future<void> clearToken(String deviceId) async {
    await _storage.delete(key: _tokenKey(deviceId));
  }

  /// Logout Clear Everything
  static Future<void> clearAll(String deviceId) async {
    await Future.wait([
      _storage.delete(key: _tokenKey(deviceId)),
      _storage.delete(key: _cometChatUidKey(deviceId)),
      _storage.delete(key: _cometChatAuthTokenKey(deviceId)),
      _storage.delete(key: _cometChatUserCreatedKey(deviceId)),
    ]);
  }

  /// Save CometChat UID
  static Future<void> saveCometChatUid({
    required String deviceId,
    required String uid,
  }) async {
    await _storage.write(key: _cometChatUidKey(deviceId), value: uid);
  }

  /// Get CometChat UID
  static Future<String?> getCometChatUid(String deviceId) async {
    return _storage.read(key: _cometChatUidKey(deviceId));
  }

  // ================= COMETCHAT AUTH TOKEN =================

  /// Save CometChat Auth Token
  static Future<void> saveCometChatAuthToken({
    required String deviceId,
    required String authToken,
  }) async {
    await _storage.write(
      key: _cometChatAuthTokenKey(deviceId),
      value: authToken,
    );
  }

  /// Get CometChat Auth Token
  static Future<String?> getCometChatAuthToken(String deviceId) async {
    return _storage.read(key: _cometChatAuthTokenKey(deviceId));
  }

  // ================= COMETCHAT USER STATUS =================

  /// Mark CometChat User Created
  static Future<void> setCometChatUserCreated({
    required String deviceId,
    required bool value,
  }) async {
    await _storage.write(
      key: _cometChatUserCreatedKey(deviceId),
      value: value.toString(),
    );
  }

  /// Check CometChat User Created
  static Future<bool> isCometChatUserCreated(String deviceId) async {
    final value = await _storage.read(key: _cometChatUserCreatedKey(deviceId));

    return value == 'true';
  }
}
