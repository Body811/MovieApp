import 'package:get_it/get_it.dart';
import 'package:movie_app/features/Movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/Movies/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/features/Movies/domain/repositories/movies_repository.dart';
import 'package:movie_app/features/Movies/domain/usecases/get_new_playing.dart';
import 'package:movie_app/features/Movies/domain/usecases/get_popular.dart';
import 'package:movie_app/features/Movies/domain/usecases/get_top_rated.dart';
import 'package:movie_app/features/Movies/domain/usecases/get_upcoming.dart';
import 'package:movie_app/features/Movies/domain/usecases/search.dart';
import 'package:movie_app/features/Movies/presentation/cubit/movies_cubit.dart';
import 'package:movie_app/features/Movies/presentation/cubit/search_movies_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Features

  // Cubit

  sl.registerFactory(() => MoviesCubit(
      getTopRated: sl(),
      getUpcoming: sl(),
      getPopular: sl(),
      getNewPlaying: sl()));
  sl.registerFactory(() => SearchMoviesCubit(search: sl()));

  // UseCases

  sl.registerLazySingleton(() => GetNewPlayingUseCase(sl()));
  sl.registerLazySingleton(() => GetTopRatedUseCase(sl()));
  sl.registerLazySingleton(() => GetPopularUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingUseCase(sl()));
  sl.registerLazySingleton(() => SearchUseCase(sl()));

  // Repository

  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(remoteDataSource: sl()));

  // DataSources

  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));

  // Core

  // External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
}
