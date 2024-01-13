import 'package:pay/features/auth/domain/entities/user.dart';
import 'package:pay/features/auth/domain/repositories/auth_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class UserDetailsParams {
  final String userId;

  UserDetailsParams({required this.userId});
}

class GetUserDetailsUseCase extends UseCase<UserEntity, UserDetailsParams> {
  final AuthRepository repository;

  GetUserDetailsUseCase(this.repository);

  @override
  Future<UserEntity> call(UserDetailsParams params) async {
    return await repository.getUserDetails(
      params.userId,
    );
  }
}
