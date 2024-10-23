import 'package:logger/logger.dart';
import 'package:movie_app/features/favorite/domain/entities/favoriteEntity.dart';
import 'package:movie_app/features/favorite/domain/repository/repository.dart';
import 'package:movie_app/usecase/usecase.dart';

class GetFavoriteItemUseCase implements UseCase<List<FavoriteEntity>, Map<String, String>> {
  final IRepository<FavoriteEntity> repo;
  final Logger _logger = Logger();

  GetFavoriteItemUseCase(this.repo);

  @override
  Future<List<FavoriteEntity>> call({Map<String, String>? params}) async {
    const usernameKey = 'username';

    if (params == null || !params.containsKey(usernameKey)) {
      _logger.e('Required parameter $usernameKey not found.');
      return [];
    }

    final username = params[usernameKey]!;
    try {
      final result = await repo.fetch(username: username);
      _logger.i('Successfully fetched favorite items for user: $username');
      return result;
    } catch (e) {
      _logger.e('Error fetching favorite items for user $username: $e');
      return [];
    }
  }
}
