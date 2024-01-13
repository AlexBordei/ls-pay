import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pay/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pay/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pay/features/auth/domain/repositories/auth_repository.dart';

import 'network/network_info.dart';

final sl = GetIt.instance;

void init() {
  // Network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
