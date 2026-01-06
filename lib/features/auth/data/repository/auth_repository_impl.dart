import 'package:blog_app_clean_architecture/core/error/exception.dart';
import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:blog_app_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/commom/entity/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  const AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteDatasource.getCurrentUserData();
      if (user != null) {
        return right(user);
      } else {
        return left(Failure('User is not logged in'));
      }
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _auth(
      authRemoteDatasource.logInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _auth(
      authRemoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _auth(Future<UserModel> authCall) async {
    try {
      final user = await authCall;
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
