import 'package:dartz/dartz.dart';
import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';
import 'package:demo_tdmovies/features/discover/domain/repositories/genres_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetGenres implements UseCase<Genres, Params> {
  final GenresRepository repository;

  GetGenres(this.repository);

  @override
  Future<Either<Failure, Genres>> call(Params params) async {
    return await repository.getGenresRepository();
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
