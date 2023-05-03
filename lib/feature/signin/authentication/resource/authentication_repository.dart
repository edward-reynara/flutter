import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  static const String _token = 'token';

  Future<void> deleteAll() async {
    // const FlutterSecureStorage storage = FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // await storage.deleteAll();
      await prefs.remove('userEmail');
      await prefs.remove('username');
      await prefs.remove('token');
      await prefs.remove('version');
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained' + e.toString());
    }
    return false;
  }

  Future<void> deleteToken() async {
    // const FlutterSecureStorage storage = FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // await storage.delete(key: _token);
      await prefs.remove('token');
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained' + e.toString());
    }
    return false;
  }

  Future<void> persistToken(String token) async {
    // const FlutterSecureStorage storage = FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // await storage.write(key: _token, value: token);
      await prefs.setString("token", token);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained' + e.toString());
    }
    return false;
  }

  Future<bool> hasToken() async {
    // const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      // String token = await storage.read(key: _token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        return true;
      }
    } on Exception catch (e) {
      print('custom exception is been obtained' + e.toString());
    }
    return false;
  }

  Future<String> fetchToken() async {
    // const FlutterSecureStorage storage = FlutterSecureStorage();
    // String token = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = '';
    try {
      // token = await storage.read(key: _token);
      token = await prefs.getString("token");
    } on Exception catch (e) {
      print('custom exception is been obtained' + e.toString());
    }
    return token;
  }
}
