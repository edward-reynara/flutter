import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ringkasan_buku/component/http/throw_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../feature/signin/authentication/model/token.dart';
import '../helper/env.dart';

class HttpProvider {
  String token = "";
  Env env;
  //final String baseUrl = env.baseUrl;

  void setToken(String token) {
    this.token = token;
  }

  Future<Map<String, dynamic>> post(String url, dynamic body,
      {String token = ''}) async {
    dynamic responseJson;
    try {
      final dynamic response =
          await http.post(Uri.encodeFull(url), body: body, headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'cache-control': 'no-cache',
        'Authorization': 'Bearer ' + this.token
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request Timeout");
    } on UnauthorisedException {
      throw UnauthorisedException("Unauthorised");
    }

    return responseJson;
  }

  Future<Map<String, dynamic>> get(String url, dynamic body,
      {String token = ''}) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.get(Uri.encodeFull(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'cache-control': 'no-cache',
        'Authorization': 'Bearer ' + this.token
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request Timeout");
    }
    return responseJson;
  }

  // Future<dynamic> get(String url, {String token = '', dynamic query}) async {
  //   //dynamic responseJson;
  //   try {
  //     final dynamic response = await http.get(Uri.encodeFull(url), headers: {
  //       'content-type': 'application/json',
  //       'accept': 'application/json',
  //       'Authorization': 'Bearer ' + token
  //     });
  //     return _response(response);
  //   } on SocketException {
  //     throw FetchDataException('No internet connection');
  //   }
  // }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        // throw UnauthorisedException(response.body.toString());
        // throw ExpiredTokenException(response.statusCode);
        final dynamic responseJson =
            jsonDecode(response.body.toString().toLowerCase());
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:

      case 500:

      case 504:
        throw RequestTimeoutException(response.body.toString());

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> delete(String url, {String token = ''}) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.delete(Uri.encodeFull(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'cache-control': 'no-cache',
        'Authorization': 'Bearer ' + this.token
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request Timeout");
    }
    return responseJson;
  }
}
