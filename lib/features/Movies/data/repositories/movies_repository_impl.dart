import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/exceptions.dart';

import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/Movies/data/datasources/movie_remote_data_source.dart';

import 'package:movie_app/features/Movies/domain/entities/Movie.dart';

import '../../domain/repositories/movies_repository.dart';
import '../models/movie_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying() async {
    return await getMessage(() {
      return remoteDataSource.getNowPlaying();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopular() async {
    return await getMessage(() {
      return remoteDataSource.getPopular();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRated() async {
    return await getMessage(() {
      return remoteDataSource.getTopRated();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcoming() async {
    return await getMessage(() {
      return remoteDataSource.getUpcoming();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> search(String Query) async {
    return await getMessage(() {
      return remoteDataSource.search(Query);
    });
  }

  Future<Either<Failure, List<Movie>>> getMessage(
      Future<List<MovieModel>> Function() getAll) async {
    try {
      final remoteMovie = await getAll();
      return Right(remoteMovie);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
