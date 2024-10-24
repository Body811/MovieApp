class FavoriteEntity {
  final String email;
  final String releaseDate;
  final String category;
  final num runtime;
  final num voteAverage;
  final String title;
  final String backDropPath;

  FavoriteEntity(
      this.releaseDate,
      this.category,
      this.runtime,
      this.voteAverage,
      this.title,
      this.backDropPath,
      this.email,
      );

  FavoriteEntity.fromJson(Map<String, Object?> json)
      : email = json['email'] as String,
        releaseDate = json['releaseDate'] as String,
        category = json['category'] as String,
        runtime = json['runtime'] as num,
        voteAverage = json['voteAverage'] as num,
        title = json['title'] as String,
        backDropPath = json['backDropPath'] as String;

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'releaseDate': releaseDate,
      'category': category,
      'runtime': runtime,
      'voteAverage': voteAverage,
      'title': title,
      'backDropPath': backDropPath,
    };
  }
}
