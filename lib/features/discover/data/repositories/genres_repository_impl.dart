import 'package:dartz/dartz.dart';
import 'package:demo_tdmovies/features/discover/data/datasources/genres_remote_data_source.dart';
import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';
import 'package:demo_tdmovies/features/discover/domain/repositories/genres_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

typedef Future<Genres> _GenresList();

class GenresRepositoryImpl implements GenresRepository {
  final GenresRemoteDataSource remoteDataSource;
  // final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GenresRepositoryImpl({
    this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, Genres>> getGenresRepository() async {
    return await _getGenres(() {
      return remoteDataSource.getGenres();
    });
  }

  Future<Either<Failure, Genres>> _getGenres(
    _GenresList getGenresList,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGenres = await getGenresList();
        // localDataSource.cacheNumberTrivia(remoteTrivia);
        // return Right(remoteTrivia);
        return Right(remoteGenres);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // try {
      //   final localTrivia = await localDataSource.getLastNumberTrivia();
      //   return Right(localTrivia);
      // } on CacheException {
        return Left(CacheFailure());
      // }
    }
  }
}
