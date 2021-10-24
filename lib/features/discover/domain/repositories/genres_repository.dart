import 'package:dartz/dartz.dart';
import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';

import '../../../../core/error/failures.dart';

abstract class GenresRepository {
  Future<Either<Failure, Genres>> getGenresRepository();
}
