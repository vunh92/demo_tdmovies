import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/collectiont.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/production_companies.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/spoken.dart';
import 'package:equatable/equatable.dart';

class UpcomingDetail extends Equatable {
  final String backdropArtUrl;
  final Collection collection;
  final int budget;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterArtUrl;
  final List<ProductionCompanies> productionCompanies;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final Spoken spokenLanguages;
  final String status;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;


  UpcomingDetail({
    this.backdropArtUrl,
    this.collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterArtUrl,
    this.productionCompanies,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  @override
  List<Object> get props => [
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
  ];
}
