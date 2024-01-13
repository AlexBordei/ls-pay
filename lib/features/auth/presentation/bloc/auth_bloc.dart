import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay/core/error/exceptions.dart';
import 'package:pay/core/service_locator.dart';
import 'package:pay/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      final AuthRepository authRepository = sl<AuthRepository>();

      emit(
        AuthLoading(),
      );

      if (event is LoginButtonPressed) {
        try {
          final user = await authRepository.login(event.email, event.password);
          emit(AuthSuccess(user));
        } catch (e) {
          if (e is ServerException) {
            // Handle the ServerException
            emit(AuthFailure(e.message ?? 'An unknown error occurred'));
          } else {
            // Handle other types of exceptions
            emit(const AuthFailure('An unknown error occurred'));
          }
        }
      } else if (event is RegisterButtonPressed) {
        try {
          final user =
              await authRepository.register(event.email, event.password);
          emit(AuthSuccess(user));
        } catch (e) {
          if (e is ServerException) {
            // Handle the ServerException
            emit(AuthFailure(e.message ?? 'An unknown error occurred'));
          } else {
            // Handle other types of exceptions
            emit(const AuthFailure('An unknown error occurred'));
          }
        }
      } else {
        throw UnimplementedError();
      }
    });
  }
}
