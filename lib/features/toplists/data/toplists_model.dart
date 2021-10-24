import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/toplists/domain/toplists.dart';

class TopListsModel extends TopLists{
  TopListsModel({
    backdropArtUrl,
    // genreIds,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterArtUrl,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount}) : super(
      backdropArtUrl: backdropArtUrl,
      // genreIds: genreIds,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterArtUrl: posterArtUrl,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount);

  factory TopListsModel.fromJson(Map<String, dynamic> json) {
    return TopListsModel(
      backdropArtUrl: MyStrings.apiImage + json['backdrop_path'],
      // genreIds: json['genre_ids'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterArtUrl: json['poster_path'],
      releaseDate: DateTime.parse(json['release_date']),
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }
}