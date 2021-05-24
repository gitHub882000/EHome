import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  final _storage = FlutterSecureStorage();
  static String userIdKey = 'uid';
  static String userEmailKey = 'email';
  static String userNameKey = 'name';
  static String userPhoneKey = 'phone';
  static String userAvtKey = 'avatar';

  Future<String> readSecureData(String key) async {
    String readData = await _storage.read(
      key: key,
    );

    return readData;
  }

  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
    );
  }

  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
