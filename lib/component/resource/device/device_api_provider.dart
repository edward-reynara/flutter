import 'dart:convert';
import 'package:meta/meta.dart';

import '../../http/http_provider.dart';

class DeviceApiProvider {
  HttpProvider apiProvider;
  final String baseUrl;

  DeviceApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<Map<String, dynamic>> deviceSave(
      String token, int userId, String deviceId, String deviceType) async {
    try {
      final String data = json.encode({
        'token': token,
        'admin_member_id': userId,
        'deviceId': deviceId,
        'deviceType': deviceType
      });
      return await apiProvider.post('$baseUrl/device', data);
    } on Error {
      //throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> deviceDelete(
      int userId, String deviceId, String deviceType) async {
    try {
      final String data = json.encode({
        'admin_member_id': userId,
        'deviceId': deviceId,
        'deviceType': deviceType
      });
      return await apiProvider.post('$baseUrl/device/delete', data);
    } on Error {
      //throw Exception('Failed to load post ' + e.toString());
    }
  }
}
