import 'package:movie_app/features/favorite/domain/entities/favoriteEntity.dart';

abstract class IRepository<T> {
  void save(FavoriteEntity favoriteItem);
  Future<List<T>> fetch({required String username, Map<String, dynamic>? params});
  void remove({required String username,  required String title, Map<String, dynamic>? params});
}