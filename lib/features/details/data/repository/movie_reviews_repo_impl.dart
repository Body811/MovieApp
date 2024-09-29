import 'package:movie_app/features/details/data/data_sources/remote/movie_reviews/movie_reviews_service.dart';
import 'package:movie_app/features/details/data/models/movie_reviews_model.dart';
import 'package:movie_app/features/details/domain/entities/movie_reviews_entity.dart';
import 'package:movie_app/features/details/domain/repository/get_list_repo.dart';

import '../../../../config/config.dart';

class MovieReviewsRepoImpl implements GetItemsListRepo<MovieReviewsEntity> {
  final MovieReviewsService _movieReviewsService;

  MovieReviewsRepoImpl(this._movieReviewsService);

  @override
  Future<List<MovieReviewsEntity>> getItems({num? id, Map<String, dynamic>? params}) async {
    try {
      final movieReviewsModel = await _movieReviewsService.getList(
        id: id,
        params: {
          'api_key': Config.API_KEY,
          'language': Config.LANGUAGE
        }
      );
      return _mapModelToEntity(movieReviewsModel[0]);
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
          review.authorDetails?.avatarPath ?? '',
          review.content ?? ''
      );
      results.add(entity);
    }
    return results;
  }
}