import 'dart:convert';

import 'package:demo_tdmovies/features/discover/data/models/genres_model.dart';
import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';

abstract class GenresRemoteDataSource {
  Future<GenresModel> getGenres();
}

class GenresRemoteDataSourceImpl implements GenresRemoteDataSource {
  final http.Client client;

  GenresRemoteDataSourceImpl({@required this.client});

  @override
  Future<GenresModel> getGenres() => _getGenresFromUrl('https://api.themoviedb.org/3/discover/movie' + MyStrings.apiKey);

  Future<GenresModel> _getGenresFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GenresModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
