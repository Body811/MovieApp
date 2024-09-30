import 'package:movie_app/features/details/data/data_sources/remote/movie_cast/movie_cast_service.dart';
import 'package:movie_app/features/details/data/models/movie_cast_model.dart';
import 'package:movie_app/features/details/domain/entities/movie_cast_entity.dart';
import 'package:movie_app/features/details/domain/repository/get_list_repo.dart';

import '../../../../config/config.dart';

class MovieCastRepoImpl implements GetItemsListRepo<MovieCastEntity> {
  final MovieCastService _movieCastService;

  MovieCastRepoImpl(this._movieCastService);

  @override
  Future<List<MovieCastEntity>> getItems({num? id, Map<String, dynamic>? params}) async {
    try {
      final movieCastModel = await _movieCastService.getList(
          id: id,
          params: {
            'api_key': Config.API_KEY,
            'language': Config.LANGUAGE
          }
      );
      return _mapModelToEntity(movieCastModel[0]);
    } catch (e) {
      rethrow;
    }
  }

  List<MovieCastEntity> _mapModelToEntity(MovieCastModel movieCastModel) {
    var cast = movieCastModel.cast;
    List<MovieCastEntity> results = [];

    if (cast == null) {
      return [];
    }

    for (var person in cast) {
      MovieCastEntity entity = MovieCastEntity(
          person.name ?? '',
          person.profilePath ?? '',
      );
      results.add(entity);
    }
    return results;
  }
}