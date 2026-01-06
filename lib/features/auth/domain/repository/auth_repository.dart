import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/commom/entity/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
