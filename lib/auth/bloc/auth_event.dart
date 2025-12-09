part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class _AuthUserChanged extends AuthEvent {
  _AuthUserChanged(this.user);
  final User? user;
}

class AuthSignInRequested extends AuthEvent {
  AuthSignInRequested({required this.email, required this.password});
  final String email;
  final String password;
}

class AuthSignUpRequested extends AuthEvent {
  AuthSignUpRequested({required this.email, required this.password});
  final String email;
  final String password;
}

class AuthSignOutRequested extends AuthEvent {}
