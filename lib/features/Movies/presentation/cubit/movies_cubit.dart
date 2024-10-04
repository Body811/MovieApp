import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/strings/failures.dart';

import '../../domain/entities/Movie.dart';
import '../../domain/usecases/get_new_playing.dart';
import '../../domain/usecases/get_popular.dart';
import '../../domain/usecases/get_top_rated.dart';
import '../../domain/usecases/get_upcoming.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetNewPlayingUseCase getNewPlaying;
  final GetPopularUseCase getPopular;
  final GetTopRatedUseCase getTopRated;
  final GetUpcomingUseCase getUpcoming;
  MoviesCubit(
      {required this.getTopRated,
      required this.getUpcoming,
      required this.getPopular,
      required this.getNewPlaying})
      : super(MoviesInitial());

  Future<void> GetNewPlayingMovies() async {
    emit(LoadingMoviesState());
    final newPlayingMoviesOrFailure = await getNewPlaying();
    emit(_mapNewPlayingMoviesOrFailure(newPlayingMoviesOrFailure));
  }

  Future<void> RefreshNewPlayingMovies() async {
    emit(LoadingMoviesState());
    final newPlayingMoviesOrFailure = await getNewPlaying();
    emit(_mapNewPlayingMoviesOrFailure(newPlayingMoviesOrFailure));
  }

  //-----------------------------------------------
  Future<void> GetPopularMovies() async {
    emit(LoadingMoviesState());
    final popularMoviesOrFailure = await getPopular();
    emit(_mapPopularMoviesOrFailure(popularMoviesOrFailure));
  }

  Future<void> RefreshPopularMovies() async {
    emit(LoadingMoviesState());
    final popularMoviesOrFailure = await getPopular();
    emit(_mapPopularMoviesOrFailure(popularMoviesOrFailure));
  }

  //-----------------------------------------------
  Future<void> GetTopRatedMovies() async {
    emit(LoadingMoviesState());
    final topRatedMoviesOrFailure = await getTopRated();
    emit(_mapTopRatedMoviesOrFailure(topRatedMoviesOrFailure));
  }

  Future<void> RefreshTopRatedMovies() async {
    emit(LoadingMoviesState());
    final topRatedMoviesOrFailure = await getTopRated();
    emit(_mapTopRatedMoviesOrFailure(topRatedMoviesOrFailure));
  }

  //-----------------------------------------------
  Future<void> GetUpcomingMovies() async {
    emit(LoadingMoviesState());
    final upcomingMoviesOrFailure = await getUpcoming();
    emit(_mapUpcomingMoviesOrFailure(upcomingMoviesOrFailure));
  }

  Future<void> RefreshUpcomingMovies() async {
    emit(LoadingMoviesState());
    final upcomingMoviesOrFailure = await getUpcoming();
    emit(_mapUpcomingMoviesOrFailure(upcomingMoviesOrFailure));
  }
//-----------------------------------------------
}

MoviesState _mapNewPlayingMoviesOrFailure(Either<Failure, List<Movie>> either) {
  return either.fold(
    (failure) => ErrorMoviesState(message: _mapFailureToMessage(failure)),
    (newPlayingMovies) =>
        LoadedNewPlayingMoviesState(newPlayingMovies: newPlayingMovies),
  );
}

MoviesState _mapPopularMoviesOrFailure(Either<Failure, List<Movie>> either) {
  return either.fold(
    (failure) => ErrorMoviesState(message: _mapFailureToMessage(failure)),
    (popularMovies) => LoadedPopularMoviesState(popularMovies: popularMovies),
  );
}

MoviesState _mapTopRatedMoviesOrFailure(Either<Failure, List<Movie>> either) {
  return either.fold(
    (failure) => ErrorMoviesState(message: _mapFailureToMessage(failure)),
    (topRatedMovies) =>
        LoadedTopRatedMoviesState(topRatedMovies: topRatedMovies),
  );
}

MoviesState _mapUpcomingMoviesOrFailure(Either<Failure, List<Movie>> either) {
  return either.fold(
    (failure) => ErrorMoviesState(message: _mapFailureToMessage(failure)),
    (upcomingMovies) =>
        LoadedUpcomingMoviesState(upcomingMovies: upcomingMovies),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
