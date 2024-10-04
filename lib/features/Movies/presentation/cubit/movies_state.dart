part of 'movies_cubit.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();
}

final class MoviesInitial extends MoviesState {
  @override
  List<Object> get props => [];
}

class LoadingMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class ErrorMoviesState extends MoviesState {
  final String message;

  ErrorMoviesState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadedNewPlayingMoviesState extends MoviesState {
  final List<Movie> newPlayingMovies;
  LoadedNewPlayingMoviesState({required this.newPlayingMovies});

  @override
  List<Object> get props => [newPlayingMovies];
}

class LoadedPopularMoviesState extends MoviesState {
  final List<Movie> popularMovies;
  LoadedPopularMoviesState({required this.popularMovies});

  @override
  List<Object> get props => [popularMovies];
}

class LoadedTopRatedMoviesState extends MoviesState {
  final List<Movie> topRatedMovies;
  LoadedTopRatedMoviesState({required this.topRatedMovies});

  @override
  List<Object> get props => [topRatedMovies];
}

class LoadedUpcomingMoviesState extends MoviesState {
  final List<Movie> upcomingMovies;
  LoadedUpcomingMoviesState({required this.upcomingMovies});

  @override
  List<Object> get props => [upcomingMovies];
}
