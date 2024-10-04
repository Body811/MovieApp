import 'package:dartz/dartz.dart';
import 'package:movie_app/features/Movies/domain/repositories/movies_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/Movie.dart';

class GetNewPlayingUseCase {
  final MoviesRepository repository;

  GetNewPlayingUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getNowPlaying();
  }
}
