import 'package:movie_app/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domain/repository/movie_details_repository.dart';
import 'package:movie_app/usecase/usecase.dart';

class GetMovieDetailsUseCase implements UseCase<MovieDetailsEntity, int> {
  final MovieDetailsRepository _movieDetailsRepository;

  GetMovieDetailsUseCase(this._movieDetailsRepository);

  @override
  Future<MovieDetailsEntity> call({int? params}) async {
    return await _movieDetailsRepository.get(params!);
  }
}