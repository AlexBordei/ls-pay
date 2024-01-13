import 'package:pay/core/usecases/usecase.dart';
import 'package:pay/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}
