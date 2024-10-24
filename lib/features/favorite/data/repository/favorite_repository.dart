import 'package:logger/logger.dart';
import 'package:movie_app/features/favorite/data/data_sources/interfaces/firebase_datasource.dart';
import 'package:movie_app/features/favorite/domain/entities/favoriteEntity.dart';
import 'package:movie_app/features/favorite/domain/repository/repository.dart';

class FavoriteRepository implements IRepository<FavoriteEntity> {
  final FirebaseDatasource _datasource;
  final Logger _logger = Logger();

  FavoriteRepository(this._datasource) {}

  @override
  Future<List<FavoriteEntity>> fetch({required String email, Map<String, dynamic>? params}) async {
    var result = [];
    try {
      result = await _datasource.fetch(email: email, params: params);
    } catch(e) {
      _logger.e('Error fetching favorites: $e');
    } finally {
      return List<FavoriteEntity>.from(result);
    }
  }

  @override
  void remove({required String email,  required String title, Map<String, dynamic>? params}) {
    try {
       _datasource.remove(email: email, title: title, params: params);
    } catch(e) {
      _logger.e('Error fetching favorites: $e');
    }
  }

  @override
  void save(FavoriteEntity favoriteItem) {
    try {
      _datasource.save(favoriteItem);
    } catch(e) {
      _logger.e('Error fetching favorites: $e');
    }
  }
}