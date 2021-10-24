import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  Collection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  @override
  List<Object> get props => [
    id,
    name,
    posterPath,
    backdropPath,
  ];

}