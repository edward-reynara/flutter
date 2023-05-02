import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/env.dart';
import '../../http/http_provider.dart';
import '../../http/response.dart';
import 'device_api_provider.dart';

class DeviceRepository {
  final HttpProvider apiProvider;
  DeviceApiProvider deviceApiProvider;
  Env env;
  SharedPreferences sharedPreferences;

  DeviceRepository({@required this.env, @required this.apiProvider}) {
    deviceApiProvider =
        DeviceApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> deviceSave() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int userId = prefs.getInt("userId");
    // String token = prefs.getString("token");
    // String deviceId = prefs.getString("deviceId");
    // String deviceType = prefs.getString("deviceType");
    // final response =
    //     await deviceApiProvider.deviceSave(token, userId, deviceId, deviceType);
    // if (response == null) {
    //   return DataResponse.connectivityError();
    // }
    // if (response["success"]) {
    //   return DataResponse.success(response["data"]);
    // } else {
    //   return DataResponse.error("Error");
    // }
  }

  Future<DataResponse<String>> deviceDelete() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int userId = prefs.getInt("userId");
    // String deviceId = prefs.getString("deviceId");
    // String deviceType = prefs.getString("deviceType");
    // final response =
    //     await deviceApiProvider.deviceDelete(userId, deviceId, deviceType);
    // if (response == null) {
    //   return DataResponse.connectivityError();
    // }
    // if (response["success"]) {
    //   return DataResponse.success(response["data"]);
    // } else {
    //   return DataResponse.error("Error");
    // }
  }
}
