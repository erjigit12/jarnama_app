part of 'auth_bloc.dart';

enum AuthStatus { unknown, loading, authenticated, unauthenticated }

@immutable
class AuthState {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
