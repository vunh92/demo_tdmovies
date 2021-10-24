import 'dart:convert';

import 'package:demo_tdmovies/features/discover/data/models/genres_model.dart';
import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/data/collection_model.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/data/production_companies_model.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/data/spoken_model.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/upcoming_detail.dart';

class UpcomingDetailModel extends UpcomingDetail{
  UpcomingDetailModel({
    backdropArtUrl,
    collection,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterArtUrl,
    productionCompanies,
    releaseDate,
    revenue,
    runtime,
    spokenLanguages,
    status,
    title,
    video,
    voteAverage,
    voteCount
  }) : super(
      backdropArtUrl: backdropArtUrl,
      collection: collection,
      budget: budget,
      genres: genres,
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterArtUrl: posterArtUrl,
      productionCompanies: productionCompanies,
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      spokenLanguages: spokenLanguages,
      status: status,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount
  );

  factory UpcomingDetailModel.fromJson(Map<String, dynamic> json) {
    return UpcomingDetailModel(
      backdropArtUrl: MyStrings.apiImage + (json['backdrop_path'] ?? ''),
      collection: json['belongs_to_collection'] != null ? CollectionModel.fromJson(json['belongs_to_collection']) : new CollectionModel(),
      budget: json['budget'],
      genres: (json['genres'] as List).map((json) => GenresModel.fromJson(json)).toList(),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterArtUrl: MyStrings.apiImage + (json['poster_path'] ?? ''),
      productionCompanies: (json['production_companies'] as List).map((json) => ProductionCompaniesModel.fromJson(json)).toList(),
      releaseDate: DateTime.parse(json['release_date']),
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List).map((json) => SpokenModel.fromJson(json)).toList()[0],
      // spokenLanguages: SpokenModel.fromJson(json['spoken_languages']),
      status: json['status'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  static String mergeGenres(List<Genres> genresList) {
    String genres = '';
    if (genresList != null && genresList.isNotEmpty)
      for (int i = 0; i < genresList.length; i++) {
        if (genres != '') genres += ', ';
        genres += genresList[i].name;
      }
    return genres;
  }
}