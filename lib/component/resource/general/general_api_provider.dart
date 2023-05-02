import 'dart:convert';
import 'package:meta/meta.dart';

import '../../http/http_provider.dart';

class GeneralApiProvider {
  HttpProvider apiProvider;
  final String baseUrl;

  GeneralApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<Map<String, dynamic>> generalUpdate(
      String version, String deviceType) async {
    try {
      final String data = json.encode({
        'version': version,
        'deviceType': deviceType,
      });
      return await apiProvider.post('$baseUrl/update', data);
    } on Error catch (e) {
      //throw Exception('Failed to load post ' + e.toString());
    }
  }
}
