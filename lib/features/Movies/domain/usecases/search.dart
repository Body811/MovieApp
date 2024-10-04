import 'package:dartz/dartz.dart';
import 'package:movie_app/features/Movies/domain/repositories/movies_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/Movie.dart';

class SearchUseCase {
  final MoviesRepository repository;

  SearchUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> call(String Query) async {
    return await repository.search(Query);
  }
}
