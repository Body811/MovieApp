class MovieDetailsEntity {
  final String posterPath;
  final String backDropPath;
  final String releaseDate;
  final String category;
  final num runtime;
  final String title;
  final String overview;
  final num voteAverage;

  MovieDetailsEntity({
    required this.voteAverage,
    required this.posterPath,
    required this.backDropPath,
    required this.releaseDate,
    required this.category,
    required this.runtime,
    required this.title,
    required this.overview
  });
}