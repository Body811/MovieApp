import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/entities/Movie.dart';
import '../../domain/usecases/search.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final SearchUseCase search;
  SearchMoviesCubit({required this.search}) : super(SearchMoviesInitial());

  Future<void> Search(String query) async {
    emit(LoadingSearchMoviesState());
    final searchMoviesOrFailure = await search(query);
    emit(_mapSearchMoviesOrFailure(searchMoviesOrFailure));
  }
}

SearchMoviesState _mapSearchMoviesOrFailure(
    Either<Failure, List<Movie>> either) {
  return either.fold(
    (failure) => ErrorSearchMoviesState(message: _mapFailureToMessage(failure)),
    (searchMovies) => LoadedSearchMoviesState(searchMovies: searchMovies),
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
