import 'package:logger/logger.dart';
import 'package:movie_app/usecase/usecase.dart';
import '../entities/favoriteEntity.dart';
import '../repository/repository.dart';

class SaveFavoriteItemUseCase implements UseCase<void, Map<String, FavoriteEntity>> {
  final IRepository<FavoriteEntity> _repo;
  final Logger _logger = Logger();

  SaveFavoriteItemUseCase(this._repo);

  @override
  Future<void> call({Map<String, FavoriteEntity>? params}) async {
    const dataKey = 'data';

    if (params == null || !params.containsKey(dataKey)) {
      _logger.e('Required parameter $dataKey not found.');
      return;
    }

    final favoriteEntity = params[dataKey];

    try {
      _repo.save(favoriteEntity!);
      _logger.i('Successfully saved favorite item: ${favoriteEntity.title}');
    } catch (e) {
      _logger.e('Error saving favorite item: $e');
    }
  }
}
