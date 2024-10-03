
import 'package:movie_app/features/auth/data/repository/register_repository_impl.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';
import 'package:movie_app/features/auth/domain/repository/auth_repository.dart';
import 'package:movie_app/usecase/usecase.dart';

import '../Params/register_user_params.dart';



class RegisterUserUsecase implements UseCase<UserEntity,RegisterUserParams> {
  final RegisterRepositoryImpl repository;

  RegisterUserUsecase({required this.repository});


  @override
  Future<UserEntity> call({RegisterUserParams? params}) async {
    if (params == null) {
      throw ArgumentError('Parameters cant be null');
    }
    final userModel = await repository.invoke(params: params);
    return UserEntity(
      uid: userModel.uid,
      email: userModel.email,
      username: userModel.username,
    );
  }
}