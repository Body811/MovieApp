import 'package:dartz/dartz.dart';
import 'package:movie_app/features/Movies/domain/entities/Movie.dart';

import '../../../../core/error/failures.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying();
  Future<Either<Failure, List<Movie>>> getUpcoming();
  Future<Either<Failure, List<Movie>>> getTopRated();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> search(String Query);
}
