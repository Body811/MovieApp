import 'package:movie_app/features/details/data/data_sources/remote/movie_reviews/movie_reviews_service.dart';
import 'package:movie_app/features/details/data/models/movie_reviews_model.dart';
import 'package:movie_app/features/details/domain/entities/movie_reviews_entity.dart';
import 'package:movie_app/features/details/domain/repository/repository.dart';

import '../../../../config/config.dart';

class MovieReviewsRepoImpl implements Repository<List<MovieReviewsEntity>> {
  final MovieReviewsService _movieReviewsService;

  MovieReviewsRepoImpl(this._movieReviewsService);

  @override
  Future<List<MovieReviewsEntity>> fetch({num? id, Map<String, dynamic>? params}) async {
    try {
      final movieReviewsModel = await _movieReviewsService.fetch(
        id: id,
        params: {
          'api_key': Config.apiKey,
          'language': Config.language
        }
      );
      return _mapModelToEntity(movieReviewsModel);
    } catch (e) {
      rethrow;
    }
  }

  List<MovieReviewsEntity> _mapModelToEntity(MovieReviewsModel movieReviewsModel) {
    List<MovieReviewsEntity> results = [];
    final reviews = movieReviewsModel.results ?? [];

    for (var review in reviews) {
      MovieReviewsEntity entity = MovieReviewsEntity(
          review.authorDetails?.rating ?? 0,
          review.author ?? '',
          Config.imageBaseUrlW500  + (review.authorDetails?.avatarPath ?? ''),
          review.content ?? ''
      );
      results.add(entity);
    }
    return results;
  }
}