import 'package:movie_app/config/config.dart';
import 'package:movie_app/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domain/repository/repository.dart';

import '../data_sources/remote/movie_details/movie_details_service.dart';
import '../models/movie_details_model.dart';

class MovieDetailsRepositoryImpl implements Repository<MovieDetailsEntity> {
  final MovieDetailsService _movieDetailsService;

  MovieDetailsRepositoryImpl(this._movieDetailsService);

  @override
  Future<MovieDetailsEntity> fetch({num? id, Map<String, dynamic>? params}) async {
    try {
      final movieDetailsModel = await _movieDetailsService.fetch(
          id: id,
          params: {
            'api_key': Config.apiKey,
            'language': Config.language
          }
      );
      return _mapModelToEntity(movieDetailsModel);
    } catch (e) {
      rethrow;
    }
  }

  MovieDetailsEntity _mapModelToEntity(MovieDetailsModel model) {
    return MovieDetailsEntity(
      posterPath:  Config.imageBaseUrlW500  + (model.posterPath ?? ''),
      backDropPath: Config.imageBaseUrlW500 + (model.backdropPath ?? ''),
      releaseDate: model.releaseDate ?? '',
      category: model.genres?.map((genre) => genre.name ?? '').join(', ') ?? '',
      runtime: model.runtime ?? 0,
      overview: model.overview ?? '',
      title: model.title ?? '',
      voteAverage: double.parse(model.voteAverage?.toStringAsFixed(2) ?? '0.00'),
    );
  }
}