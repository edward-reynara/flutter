import 'package:shared_preferences/shared_preferences.dart';
import 'package:ringkasan_buku/component/helper/preferences.dart';

class SharedPreferenceHelper {
  final Future<SharedPreferences> _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  //  General Method:-----------------------------------------------------------
  Future<void> saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
    });
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.refresh_token, refreshToken);
    });
  }
}
