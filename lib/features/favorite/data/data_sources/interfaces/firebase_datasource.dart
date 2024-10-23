import '../../../domain/entities/favoriteEntity.dart';

abstract class FirebaseDatasource<T>{
  void save(FavoriteEntity favoriteItem);
  Future<List<T>> fetch({required String username, Map<String, dynamic>? params});
  void remove({required String username, required String title, Map<String, dynamic>? params});
}
