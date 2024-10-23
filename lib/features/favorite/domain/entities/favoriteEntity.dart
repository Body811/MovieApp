class FavoriteEntity {
  final String username;
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
      this.username,
      );

  FavoriteEntity.fromJson(Map<String, Object?> json)
      : username = json['username'] as String,
        releaseDate = json['releaseDate'] as String,
        category = json['category'] as String,
        runtime = json['runtime'] as num,
        voteAverage = json['voteAverage'] as num,
        title = json['title'] as String,
        backDropPath = json['backDropPath'] as String;

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'releaseDate': releaseDate,
      'category': category,
      'runtime': runtime,
      'voteAverage': voteAverage,
      'title': title,
      'backDropPath': backDropPath,
    };
  }
}
