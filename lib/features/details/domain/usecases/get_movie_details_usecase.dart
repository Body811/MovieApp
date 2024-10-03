
import '/features/details/data/repository/movie_details_repository_impl.dart';
import '/features/details/domain/entities/movie_details_entity.dart';
import '/usecase/usecase.dart';


class GetMovieDetailsUseCase implements UseCase<MovieDetailsEntity, num> {
  final MovieDetailsRepositoryImpl _movieDetailsRepository;

  GetMovieDetailsUseCase(this._movieDetailsRepository);

  @override
  Future<MovieDetailsEntity> call({num? params}) async {
    if (params == null) {
      throw Exception('Params cannot be null');
    }
    return await _movieDetailsRepository.fetch(id: params);
  }
}