import 'package:movie_app/features/details/data/repository/movie_reviews_repo_impl.dart';
import 'package:movie_app/features/details/domain/entities/movie_reviews_entity.dart';
import 'package:movie_app/usecase/usecase.dart';

class GetMovieReviewsUseCase implements UseCase<List<MovieReviewsEntity>, num> {
  MovieReviewsRepoImpl movieReviewsRepoImpl;

  GetMovieReviewsUseCase(this.movieReviewsRepoImpl);

  @override
  Future<List<MovieReviewsEntity>> call({num? params}) {
    if (params == null) {
      throw Exception('Params cannot be null');
    }
    return movieReviewsRepoImpl.fetch(id: params);
  }
}