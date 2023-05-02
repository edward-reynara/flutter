import 'package:meta/meta.dart';
import '../../../component/helper/env.dart';
import '../../../component/http/http_provider.dart';
import '../../../component/http/response.dart';
import 'home_api_provider.dart';

class HomeRepository {
  final HttpProvider apiProvider;
  HomeApiProvider homeApiProvider;
  Env env;

  HomeRepository({@required this.env, @required this.apiProvider}) {
    homeApiProvider =
        HomeApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> updateProduct(
      String name,
      String purchase_date,
      int warranty_month,
      String description,
      String note,
      int category_id,
      int brand_id,
      int supplier_id,
      int product_id,
      String photo,
      String receipt0,
      String receipt1,
      String receipt2) async {
    final response = await homeApiProvider.updateProductApi(
        name,
        purchase_date,
        warranty_month,
        description,
        note,
        category_id,
        brand_id,
        supplier_id,
        product_id,
        photo,
        receipt0,
        receipt1,
        receipt2);

    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response["message"] == "unauthenticated." ||
        response["message"] == "401") {
      return DataResponse.error(response["message"]);
    }
    if (response["success"]) {
      return DataResponse.successMessage(response["message"]);
    } else {
      return DataResponse.error(response["message"]);
    }
  }

  Future<DataResponse<String>> deleteProductData(int id) async {
    final response = await homeApiProvider.deleteProductApi(id);
    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response["message"] == "unauthenticated." ||
        response["message"] == "401") {
      return DataResponse.error(response["message"]);
    }
    if (response["success"]) {
      return DataResponse.successMessage(response["message"]);
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<String>> getStatusProductData() async {
    final response = await homeApiProvider.getStatusApi();
    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response["message"] == "unauthenticated." ||
        response["message"] == "401") {
      return DataResponse.error(response["message"]);
    }
    if (response["success"]) {
      try {
        return DataResponse.success(response["data"]);
      } catch (e) {
        return DataResponse.error(e.toString());
      }
    } else {
      return DataResponse.error("Error");
    }
  }
}
