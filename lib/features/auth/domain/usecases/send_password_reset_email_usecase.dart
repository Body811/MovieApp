



import '../../../../usecase/usecase.dart';
import '../../data/repository/send_password_reset_email_repository_impl.dart';

class SendPasswordResetEmailUsecase implements UseCase<void,String> {

  final SendPasswordResetEmailRepositoryImpl repository;
  SendPasswordResetEmailUsecase({required this.repository});


  @override
  Future<void> call({String? params}) async {
    if (params == null) {
      throw ArgumentError('Parameters cant be null');
    }
    await repository.invoke(params: params);

  }
}