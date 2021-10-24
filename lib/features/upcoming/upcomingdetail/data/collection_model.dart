import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/collectiont.dart';

class CollectionModel extends Collection {
  CollectionModel({
    id,
    name,
    posterPath,
    backdropPath,
  }) : super(
    id: id,
    name: name,
    posterPath: posterPath,
    backdropPath: backdropPath,
  );

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'] != null ? MyStrings.apiImage + json['poster_path'] : '',
      backdropPath: json['backdrop_path'] != null ? MyStrings.apiImage + json['backdrop_path'] : '',
    );
  }
}