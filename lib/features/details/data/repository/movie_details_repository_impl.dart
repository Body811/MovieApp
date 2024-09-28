import 'package:movie_app/config/config.dart';
import 'package:movie_app/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domain/repository/movie_details_repository.dart';

import '../data_sources/remote/movie_details/movie_details_service.dart';
import '../models/movie_details_model.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsService _movieDetailsService;

  MovieDetailsRepositoryImpl(this._movieDetailsService);

  @override
  Future<MovieDetailsEntity> get(int movieId) async {
    try {
      final movieDetailsModel = await _movieDetailsService.getItem(
          id: movieId,
          params: {
            'api_key': Config.API_KEY,
            'language': Config.LANGUAGE
          }
      );
      return _mapModelToEntity(movieDetailsModel);
    } catch (e) {
      rethrow;
    }
  }

  MovieDetailsEntity _mapModelToEntity(MovieDetailsModel model) {
    return MovieDetailsEntity(
      posterPath: model.posterPath ?? '',
      backDropPath: model.backdropPath ?? '',
      releaseDate: model.releaseDate ?? '',
      category: model.genres?.map((genre) => genre.name ?? '').join(', ') ?? '',
      runtime: model.runtime ?? 0,
      overview: model.overview ?? '',
      title: model.title ?? '',
    );
  }
}