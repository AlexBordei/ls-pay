import 'package:pay/core/error/exceptions.dart';
import 'package:pay/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<UserModel> fetchUserDetails(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    final supabase = Supabase.instance.client;

    try {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: password);
      final User? user = res.user;

      if (user != null) {
        return UserModel(
          id: user.id,
          email: user.email ?? '',
          name: '',
        );
      } else {
        throw ServerException(message: 'Supabase error');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    final supabase = Supabase.instance.client;
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final User? user = res.user;

      if (user != null) {
        return UserModel(
          id: user.id,
          email: user.email ?? '',
          name: '',
        );
      } else {
        throw ServerException(message: 'Supabase error');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> fetchUserDetails(String userId) async {
    final supabase = Supabase.instance.client;

    try {
      final Session? session = supabase.auth.currentSession;

      if (session == null) {
        throw ServerException(message: 'User not logged in');
      }

      return UserModel(
        id: session.user.id,
        email: session.user.email ?? '',
        name: '',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
