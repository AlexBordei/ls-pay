import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay/core/service_locator.dart';
import 'package:pay/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      final AuthRepository authRepository = sl<AuthRepository>();

      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.email, event.password);
        emit(AuthSuccess(user));
      } catch (ServerException error) {
        emit(AuthFailure(error.message));
      }
    });
  }
}
