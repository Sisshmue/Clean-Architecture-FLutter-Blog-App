import 'package:blog_app_clean_architecture/features/auth/domain/entity/user.dart';
import 'package:blog_app_clean_architecture/features/auth/domain/usecases/user_log_in.dart';
import 'package:blog_app_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  AuthBloc({required UserSignUp userSignUp, required UserLogIn userLogin})
    : _userSignUp = userSignUp,
      _userLogIn = userLogin,
      super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);

    on<AuthLogIn>(_onLogIn);
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(event.name, event.email, event.password),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogIn(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
