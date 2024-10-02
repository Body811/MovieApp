import 'package:movie_app/features/details/data/data_sources/remote/movie_cast/movie_cast_service.dart';
import 'package:movie_app/features/details/data/models/movie_cast_model.dart';
import 'package:movie_app/features/details/domain/entities/movie_cast_entity.dart';
import 'package:movie_app/features/details/domain/repository/repository.dart';

import '../../../../config/config.dart';

class MovieCastRepoImpl implements Repository<List<MovieCastEntity>> {
  final MovieCastService _movieCastService;

  MovieCastRepoImpl(this._movieCastService);

  @override
  Future<List<MovieCastEntity>> fetch({num? id, Map<String, dynamic>? params}) async {
    try {
      final movieCastModel = await _movieCastService.fetch(
          id: id,
          params: {
            'api_key': Config.apiKey,
            'language': Config.language
          }
      );
      return _mapModelToEntity(movieCastModel);
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
        Config.imageBaseUrlW500 + (person.profilePath ?? ''),
      );
      results.add(entity);
    }
    return results;
  }
}