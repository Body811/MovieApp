import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final bool adult;
  final String backdrop_path;
  final int id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String poster_path;
  final DateTime release_date;
  final String title;
  final double vote_average;

  Movie(
      {required this.adult,
      required this.backdrop_path,
      required this.id,
      required this.original_language,
      required this.original_title,
      required this.overview,
      required this.popularity,
      required this.poster_path,
      required this.release_date,
      required this.title,
      required this.vote_average});

  @override
  List<Object?> get props => [
        adult,
        backdrop_path,
        id,
        original_language,
        original_title,
        overview,
        popularity,
        poster_path,
        release_date,
        title,
        vote_average
      ];
}
