import 'package:meta/meta.dart';

import '../../../component/helper/env.dart';
import '../../../component/http/http_provider.dart';
import 'genre_api_provider.dart';

class GenreRepository {
  final HttpProvider apiProvider;
  GenreApiProvider genreApiProvider;
  Env env;

  GenreRepository({@required this.env, @required this.apiProvider}) {
    genreApiProvider =
        GenreApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }
}
