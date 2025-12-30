import 'package:blog_app_clean_architecture/core/error/exception.dart';
import 'package:blog_app_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _auth(
      supabaseClient.auth.signInWithPassword(email: email, password: password),
    );
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _auth(
      supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      ),
    );
  }

  Future<UserModel> _auth(Future<AuthResponse> authCall) async {
    try {
      final response = await authCall;
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
