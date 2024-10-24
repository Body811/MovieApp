import '../../../domain/entities/favoriteEntity.dart';

abstract class FirebaseDatasource<T>{
  void save(FavoriteEntity favoriteItem);
  Future<List<T>> fetch({required String email, Map<String, dynamic>? params});
  void remove({required String email, required String title, Map<String, dynamic>? params});
}
