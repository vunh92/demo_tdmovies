import 'package:equatable/equatable.dart';

class TopLists extends Equatable {
  final String backdropArtUrl;
  // final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterArtUrl;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  TopLists({
    this.backdropArtUrl,
    // this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterArtUrl,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  @override
  List<Object> get props => [
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
    voteCount
  ];
}
