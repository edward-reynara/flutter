import 'dart:convert';

import 'package:meta/meta.dart';

import '../../../component/http/http_provider.dart';

class AuthApiProvider {
  HttpProvider apiProvider;
  final String baseUrl;

  AuthApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<Map<String, dynamic>> signIn(
      String email,
      String password,
      String tokenFcm,
      String deviceType,
      String deviceId,
      String deviceName,
      String deviceInformation) async {
    try {
      // final String data = json.encode({
      //   'email': email,
      //   'password': password,
      //   'device_token': tokenFcm,
      //   'device_type': deviceType,
      //   'device_id': deviceId,
      //   'device_name': deviceName,
      //   'device_information': deviceInformation,
      // });
      Map params = {"email": email, "password": password};
      if (tokenFcm != "") {
        params["device_token"] = tokenFcm;
      }
      if (deviceType != "") {
        params["device_type"] = deviceType;
      }
      if (deviceId != "") {
        params["device_id"] = deviceId;
      }
      if (deviceName != "") {
        params["device_name"] = deviceName;
      }
      if (deviceName != "") {
        params["device_information"] = deviceInformation;
      }
      final String data = json.encode(params);
      return await apiProvider.post('$baseUrl/v1/auth/login', data);
    } on Error catch (e) {
      //throw Exception('Failed to load signIn ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> signUp(
      String email, String password, String confirm_password, name) async {
    try {
      final String data = json.encode({
        'email': email,
        'password': password,
        'confirm_password': confirm_password,
        'name': name
      });
      return await apiProvider.post('$baseUrl/v1/auth/register', data);
    } on Error catch (e) {
      throw Exception('Failed to load signUp ' + e.toString());
    }
  }
}
