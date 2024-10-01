import 'package:movie_app/config/config.dart';
import 'package:movie_app/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domain/repository/get_item_repo.dart';

import '../data_sources/remote/movie_details/movie_details_service.dart';
import '../models/movie_details_model.dart';

class MovieDetailsRepositoryImpl implements GetItemRepo<MovieDetailsEntity> {
  final MovieDetailsService _movieDetailsService;
  final imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  MovieDetailsRepositoryImpl(this._movieDetailsService);

  @override
  Future<MovieDetailsEntity>  getItem({required num id, Map<String, dynamic>? params}) async {
    try {
      final movieDetailsModel = await _movieDetailsService.getItem(
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
      posterPath: imageBaseUrl + (model.posterPath ?? ''),
      backDropPath: imageBaseUrl + (model.backdropPath ?? ''),
      releaseDate: model.releaseDate ?? '',
      category: model.genres?.map((genre) => genre.name ?? '').join(', ') ?? '',
      runtime: model.runtime ?? 0,
      overview: model.overview ?? '',
      title: model.title ?? '',
      voteAverage: double.parse(model.voteAverage?.toStringAsFixed(2) ?? '0.00'),
    );
  }
}