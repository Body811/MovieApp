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
    const emailKey = 'email';

    if (params == null || !params.containsKey(emailKey)) {
      _logger.e('Required parameter $emailKey not found.');
      return [];
    }

    final email = params[emailKey]!;
    try {
      final result = await repo.fetch(email: email);
      _logger.i('Successfully fetched favorite items for user: $email');
      return result;
    } catch (e) {
      _logger.e('Error fetching favorite items for user $email: $e');
      return [];
    }
  }
}
