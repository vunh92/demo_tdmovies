import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';

class GenresModel extends Genres{
  GenresModel({
    id,
    name
  }) : super(
      id: id,
      name: name
  );

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['id'],
      name: json['name'],
    );
  }
}