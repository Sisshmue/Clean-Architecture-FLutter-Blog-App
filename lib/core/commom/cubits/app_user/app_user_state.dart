part of 'app_user_cubit.dart';

class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggIn extends AppUserState {
  final User user;
  AppUserLoggIn(this.user);
}
