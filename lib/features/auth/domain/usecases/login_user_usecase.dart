


import 'package:movie_app/features/auth/data/repository/login_repository_impl.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';
import 'package:movie_app/features/auth/domain/repository/auth_repository.dart';
import 'package:movie_app/usecase/usecase.dart';

import '../Params/login_user_params.dart';



class LoginUserUsecase implements UseCase<void,LoginUserParams>{
  final LoginRepositoryImpl repository;

  LoginUserUsecase({required this.repository});

  @override
  Future<void> call({LoginUserParams? params}) async {
    if(params == null){
      throw ArgumentError('Parameters cant be null');
    }
    return await repository.invoke(params: params);
  }
}