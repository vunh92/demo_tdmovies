import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:http/http.dart' as http;

class GenresApi {
  final String apiServer = 'https://api.themoviedb.org/3/genre/movie';

  Future<http.Response> getGenresListSubCategory() async {
    final header = getHeader();
    String url =
        apiServer + MyStrings.apiKey;
    return http.get(url, headers: header);
  }

  Map<String, String> getHeader() {
    return ({
      'Content-Type': 'application/json',
    });
  }

}