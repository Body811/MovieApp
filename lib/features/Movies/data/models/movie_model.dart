import 'package:movie_app/features/Movies/domain/entities/Movie.dart';

class MovieModel extends Movie {
  final bool adult;
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  }) : super(
          adult: adult,
          backdrop_path: backdropPath,
          id: id,
          original_language: originalLanguage,
          original_title: originalTitle,
          overview: overview,
          popularity: popularity,
          poster_path: posterPath,
          release_date: releaseDate,
          title: title,
          vote_average: voteAverage,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        id: json["id"] ?? 0,
        originalLanguage: json["original_language"] ?? "",
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        popularity:
            (json["popularity"] != null) ? json["popularity"].toDouble() : 0.0,
        posterPath: json["poster_path"] ?? "",
        releaseDate: json["release_date"] != null
            ? (DateTime.tryParse(json["release_date"]) ??
                DateTime(2000, 12, 12))
            : DateTime(2000, 12, 12),
        title: json["title"] ?? "",
        voteAverage: (json["vote_average"] != null)
            ? json["vote_average"].toDouble()
            : 0.0,
      );
}
