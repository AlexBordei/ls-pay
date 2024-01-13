import 'package:pay/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<UserEntity> call(RegisterParams params) async {
    return await repository.register(params.email, params.password);
  }
}
