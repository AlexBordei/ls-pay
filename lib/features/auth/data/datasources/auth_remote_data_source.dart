import 'dart:convert';

import 'package:pay/core/error/exceptions.dart';
import 'package:pay/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';
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
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (user != null) {
        return UserModel(
          id: user.id,
          email: user.email ?? '',
          name: user.userMetadata?.fullName ?? '',
        );
      } else {
        throw ServerException(message: 'Supabase error');
      }
    } catch (e) {
      throw ServerException(message: 'Supabase error');
    }

    // final response = await http.Client().post(
    //   Uri.parse('https://example.com/api/login'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'email': email, 'password': password}),
    // );

    // if (response.statusCode == 200) {
    //   return UserModel.fromJson(jsonDecode(response.body));
    // } else {
    //   throw ServerException();
    // }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    final response = await http.Client().post(
      Uri.parse('https://example.com/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> fetchUserDetails(String userId) async {
    final response = await http.Client().get(
      Uri.parse('https://example.com/api/user/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
