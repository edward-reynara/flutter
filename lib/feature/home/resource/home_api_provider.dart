import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/http/http_provider.dart';

class HomeApiProvider {
  HttpProvider apiProvider;
  final String baseUrl;

  HomeApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<Map<String, dynamic>> getHomeProductApi(
      int page) async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response = await apiProvider.get(
          '$baseUrl/v1/product' +
              '?page=' +
              page.toString(),
          null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getHomeProductActiveApi(
      int page) async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response = await apiProvider.get(
          '$baseUrl/v1/product' +
              '?page=' +
              page.toString() +
              '&status=active',
          null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getHomeProductExpiringApi(
      int page) async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response = await apiProvider.get(
          '$baseUrl/v1/product' +
              '?page=' +
              page.toString() +
              '&status=expiring',
          null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getHomeProductExpiredApi(
      int page) async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response = await apiProvider.get(
          '$baseUrl/v1/product' +
              '?page=' +
              page.toString() +
              '&status=expired',
          null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getCategoryApi() async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response =
          await apiProvider.get('$baseUrl/v1/product-category', null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getBrandApi() async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response =
          await apiProvider.get('$baseUrl/v1/brand', null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getSupplierApi() async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response =
          await apiProvider.get('$baseUrl/v1/supplier', null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> updateProductApi(
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
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);

      Map params = {
        "name": name,
        "purchase_date": purchase_date,
        "warranty_month": warranty_month,
        "description": description,
        "notes": note,
      };
      if (category_id != 0) {
        params["category_id"] = category_id;
      }
      if (brand_id != 0) {
        params["brand_id"] = brand_id;
      }
      if (supplier_id != 0) {
        params["supplier_id"] = supplier_id;
      }
      if (photo != null) {
        params['photo'] = photo;
      }

      List<String> receipts = <String>[];
      if (receipt0 != null) {
        receipts.add(receipt0);
      }
      if (receipt1 != null) {
        receipts.add(receipt1);
      }
      if (receipt2 != null) {
        receipts.add(receipt2);
      }
      if (receipts.length > 0) {
        params['receipt'] = receipts;
      }

      final String data = json.encode(params);

      Map<String, dynamic> response = await apiProvider.post(
          '$baseUrl/v1/product/update/' + product_id.toString(), data);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> deleteProductApi(int id) async {
    try {
      return await apiProvider.delete('$baseUrl/v1/product/destroy/$id');
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getSearchProductDataApi(
      String categoryId, String text, int page) async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);

      String url = '$baseUrl/v1/product?';
      if (categoryId != null && categoryId != '') {
        url = url + '&category_id=' + categoryId;
      }
      if (text != null && text != '') {
        url = url + '&name=' + text;
      }
      if (page != null && page != '') {
        url = url + '&page=' + page.toString();
      }
      print("getSearchProductDataApi:" + url);
      Map<String, dynamic> response = await apiProvider.get(url, null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }

  Future<Map<String, dynamic>> getStatusApi() async {
    try {
      //TODO insert from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      apiProvider.setToken(token);
      Map<String, dynamic> response =
      await apiProvider.get('$baseUrl/v1/product/count', null);
      return response;
    } on Error catch (e) {
      throw Exception("Failed to load data " + e.toString());
    }
  }
}

