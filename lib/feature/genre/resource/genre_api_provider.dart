import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/http/http_provider.dart';

class GenreApiProvider {
  HttpProvider apiProvider;
  final String baseUrl;

  GenreApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);
}
