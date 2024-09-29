import 'package:dio/dio.dart';
import 'package:movie_app/features/details/data/data_sources/remote/interfaces/get_list_datasource.dart';
import 'package:movie_app/features/details/data/models/movie_reviews_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'movie_reviews_service.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3/movie/')
abstract class MovieReviewsService implements GetListDatasource<MovieReviewsModel> {
  factory MovieReviewsService(Dio dio) = _MovieReviewsService;

  @override
  @GET('{id}/reviews')
  Future<List<MovieReviewsModel>> getList({
    @Path('id') num? id,
    @Queries() Map<String, dynamic>? params
  });
}