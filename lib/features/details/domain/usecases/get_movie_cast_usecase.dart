import 'package:movie_app/features/details/domain/entities/movie_cast_entity.dart';
import 'package:movie_app/usecase/usecase.dart';

import '../../data/repository/movie_cast_repo_impl.dart';

class GetMovieCastUseCase implements UseCase<List<MovieCastEntity>, num> {
  final MovieCastRepoImpl _movieCastRepository;

  GetMovieCastUseCase(this._movieCastRepository);

  @override
  Future<List<MovieCastEntity>> call({num? params}) async {
    if (params == null) {
      throw Exception('Params cannot be null');
    }
    return await _movieCastRepository.getItems(id: params);
  }
}