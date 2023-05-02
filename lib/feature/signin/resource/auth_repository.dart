import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/helper/env.dart';
import '../../../component/helper/internet_check.dart';
import '../../../component/http/http_provider.dart';
import '../../../component/http/response.dart';
import 'auth_api_provider.dart';

class AuthRepository {
  final HttpProvider apiProvider;
  AuthApiProvider authApiProvider;
  InternetCheck internetCheck;
  SharedPreferences sharedPreferences;
  Env env;

  AuthRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck}) {
    authApiProvider =
        AuthApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> signIn(
      String email,
      String password,
      String tokenFcm,
      String deviceType,
      String deviceId,
      String deviceName,
      String deviceInformation) async {
    final response = await authApiProvider.signIn(email, password, tokenFcm,
        deviceType, deviceId, deviceName, deviceInformation);
    print("__edores:" + response.toString());
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response["success"]) {
      return DataResponse.successLogin(response["token"], response["user"]);
    } else {
      return DataResponse.error(response["message"]);
    }
  }

  Future<DataResponse<String>> signUp(String email, String password,
      String confirm_password, String name) async {
    final response =
        await authApiProvider.signUp(email, password, confirm_password, name);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response["success"]) {
      return DataResponse.successMessage(response["message"]);
    } else {
      return DataResponse.error(response["message"]);
    }
  }
}
