import 'package:get_it/get_it.dart';
import 'package:pay/core/error/exceptions.dart';
import 'package:pay/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pay/features/auth/data/models/user_model.dart';
import 'package:pay/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      UserModel userModel = await remoteDataSource.login(email, password);
      return userModel;
    } else {
      throw ServerException(
        message: 'No internet connection',
      );
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    if (await networkInfo.isConnected) {
      UserModel userModel = await remoteDataSource.register(email, password);
      return userModel;
    } else {
      throw ServerException(
        message: 'No internet connection',
      );
    }
  }

  @override
  Future<UserModel> getUserDetails(String userId) async {
    if (await networkInfo.isConnected) {
      UserModel userModel = await remoteDataSource.fetchUserDetails(userId);
      return userModel;
    } else {
      throw ServerException(
        message: 'No internet connection',
      );
    }
  }
}
