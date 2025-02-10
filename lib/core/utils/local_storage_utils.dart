import 'package:get_storage/get_storage.dart';

class LocalStorageUtils {
  static final _localStorage = GetStorage();

  static String? getAccessToken() {
    final token = _localStorage.read<String>("token");

    return token;
  }

  static Future<void> updateToken(String token) async {
    await _localStorage.write("token", token);
  }
}
