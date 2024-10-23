import 'package:logger/logger.dart';
import 'package:movie_app/features/favorite/domain/entities/favoriteEntity.dart';
import 'package:movie_app/features/favorite/domain/repository/repository.dart';
import 'package:movie_app/usecase/usecase.dart';

class DeleteFavoriteItemUseCase implements UseCase<void, Map<String, String>> {
  final IRepository repo;
  final Logger _logger = Logger();

  DeleteFavoriteItemUseCase(this.repo);

  @override
  Future<void> call({Map<String, String>? params}) async {
    const usernameKey = 'username';
    const titleKey = 'title';

    if (params != null && params.containsKey(usernameKey) && params.containsKey(titleKey)) {
      try {
        repo.remove(username: params[usernameKey]!, title: params[titleKey]!);
        _logger.i('Successfully removed favorite item: ${params[titleKey]} for user: ${params[usernameKey]}');
      } catch (e) {
        _logger.e('Error removing favorite item: $e');
      }
    } else {
      _logger.e('Required parameters not found: username and title must be provided');
    }
  }
}
