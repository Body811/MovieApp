import 'package:dio/dio.dart';
import 'package:movie_app/features/details/data/data_sources/remote/remote_datasource.dart';
import 'package:movie_app/features/details/data/models/movie_details_model.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_details_service.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3/movie/')
abstract class MovieDetailsService implements RemoteDatasource<MovieDetailsModel> {
  factory MovieDetailsService(Dio dio) = _MovieDetailsService;

  @override
  @GET('{id}')
  Future<MovieDetailsModel> getItem({
    @Path('id') required int id,
    @Queries() Map<String, dynamic>? params
  });
}
