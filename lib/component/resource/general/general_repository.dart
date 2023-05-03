import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/env.dart';
import '../../http/http_provider.dart';
import '../../http/response.dart';
import 'general_api_provider.dart';

class GeneralRepository {
  final HttpProvider apiProvider;
  GeneralApiProvider generalApiProvider;
  Env env;
  SharedPreferences sharedPreferences;

  GeneralRepository({@required this.env, @required this.apiProvider}) {
    generalApiProvider =
        GeneralApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> deviceUpdate() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    // String buildNumber = "";
    // String deviceType = Platform.operatingSystem;
    // final response =
    //     await generalApiProvider.generalUpdate(buildNumber, deviceType);
    // if (response == null) {
    //   return DataResponse.connectivityError();
    // }
    // if (response["success"]) {
    //   return DataResponse.forceUpdate(response["isForceUpdate"]);
    // } else {
    //   return DataResponse.error("Error");
    // }
  }
}
