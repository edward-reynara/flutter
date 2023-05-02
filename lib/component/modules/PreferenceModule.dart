

import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/shared_preferences_helper.dart';

class PreferenceModule {
  Future<SharedPreferences> sharedPref;

  PreferenceModule() {
    sharedPref = provideSharedPreferences();
  }

  @provide
  @singleton
  @asynchronous
  Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  @provide
  @singleton
  SharedPreferenceHelper provideSharedPreferenceHelper() {
    return SharedPreferenceHelper(sharedPref);
  }
}
