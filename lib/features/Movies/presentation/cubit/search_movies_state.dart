part of 'search_movies_cubit.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();
}

final class SearchMoviesInitial extends SearchMoviesState {
  @override
  List<Object> get props => [];
}

class LoadingSearchMoviesState extends SearchMoviesState {
  @override
  List<Object?> get props => [];
}

class ErrorSearchMoviesState extends SearchMoviesState {
  final String message;

  ErrorSearchMoviesState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadedSearchMoviesState extends SearchMoviesState {
  final List<Movie> searchMovies;

  LoadedSearchMoviesState({required this.searchMovies});

  @override
  List<Object?> get props => [searchMovies];
}
