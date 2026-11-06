import 'package:hive_flutter/hive_flutter.dart';
import 'package:oinder/core/services/Hive/hive_keys.dart';

class HiveDataBase {
  static Box? _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('remtronLocal');
  }

  static Box get box {
    if (_box == null) {
      throw StateError('Hive not initialized');
    }
    return _box!;
  }

  /// save park id
  static saveToken({required String token}) {
    HiveDataBase.box.put(HiveKeys.token, token);
  }

  // save user id
  static saveUserId({required String userId}) {
    HiveDataBase.box.put(HiveKeys.userId, userId);
  }

  // get park id
  static String getUserId() {
    return HiveDataBase.box.get(HiveKeys.userId) ?? '';
  }

  // get park id
  static String getToken() {
    return box.get(HiveKeys.token, defaultValue: '');
  }

  // Save user name
  static saveName({required String name}) {
    HiveDataBase.box.put(HiveKeys.userName, name);
  }

  // Get user name
  static String getName() {
    return HiveDataBase.box.get(HiveKeys.userName, defaultValue: '');
  }

  // Save user email
  static saveEmail({required String userEmail}) {
    HiveDataBase.box.put(HiveKeys.userEmail, userEmail);
  }

  // Get user email
  static String getUserEmail() {
    return HiveDataBase.box.get(HiveKeys.userEmail, defaultValue: '');
  }

  // Save user Number
  static savePhoneNumber({required String userNumber}) {
    HiveDataBase.box.put(HiveKeys.userPhoneNumber, userNumber);
  }

  // Get user Number
  static String getPhoneNumber() {
    return HiveDataBase.box.get(HiveKeys.userPhoneNumber, defaultValue: '');
  }

  static String getSelectedLanguage() {
    return box.get('language', defaultValue: '');
  }

  static Future<void> setSelectedLanguage(String lang) async {
    await box.put('language', lang);
  }

  static Future<void> saveDoctorRegistrationDraft(
    Map<String, dynamic> data,
  ) async {
    await box.put(HiveKeys.doctorRegistrationDraft, data);
  }

  static Map<String, dynamic>? getDoctorRegistrationDraft() {
    final data = box.get(HiveKeys.doctorRegistrationDraft);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  static Future<void> clearDoctorRegistrationDraft() async {
    await box.delete(HiveKeys.doctorRegistrationDraft);
  }

  // Save user gender
  static Future<void> saveGender({required String gender}) async {
    await HiveDataBase.box.put(HiveKeys.userGender, gender);
  }

  // Get user gender
  static String getGender() {
    return HiveDataBase.box.get(HiveKeys.userGender, defaultValue: '');
  }

  /// clear hive data
  static clearHiveData() async {
    await HiveDataBase.box.clear();
  }
}
