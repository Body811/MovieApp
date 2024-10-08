import 'package:dio/dio.dart';
import 'package:movie_app/features/details/data/data_sources/remote/interfaces/remote_datasource.dart';
import 'package:movie_app/features/details/data/models/movie_cast_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'movie_cast_service.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3/movie/')
abstract class MovieCastService implements RemoteDatasource<MovieCastModel> {
  factory MovieCastService(Dio dio) = _MovieCastService;
  
  @GET('{id}/credits')
  @override
  Future<MovieCastModel> fetch({
    @Path('id') num? id,
    @Queries() Map<String, dynamic>? params
  });
}