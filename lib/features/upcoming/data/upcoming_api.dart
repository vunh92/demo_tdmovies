import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:http/http.dart' as http;

class UpcomingApi {
  final String api_server = 'https://api.themoviedb.org/3/movie/upcoming';

  Future<http.Response> getUpcomingList() async {
    final header = getHeader();
    String url =
        api_server + MyStrings.apiKey;
    return http.get(url, headers: header);
  }

  Map<String, String> getHeader() {
    return ({
      'Content-Type': 'application/json',
    });
  }
}