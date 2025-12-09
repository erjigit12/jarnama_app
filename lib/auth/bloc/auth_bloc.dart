import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<_AuthUserChanged>(_onUserChanged);
    on<AuthSignInRequested>(_onSignIn);
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthSignOutRequested>(_onSignOut);

    _subscription = _repository.authStateChanges.listen(
      (user) => add(_AuthUserChanged(user)),
    );

    add(AuthStarted());
  }

  final AuthRepository _repository;
  StreamSubscription<User?>? _subscription;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final user = _repository.currentUser;
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void _onUserChanged(_AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: event.user));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
    }
  }

  Future<void> _onSignIn(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _repository.signIn(email: event.email, password: event.password);
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage:
              '${e.code}: ${e.message ?? 'Не удалось войти, попробуйте ещё раз'}',
        ),
      );
      return;
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Не удалось войти',
        ),
      );
      return;
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onSignUp(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _repository.signUp(email: event.email, password: event.password);
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage:
              '${e.code}: ${e.message ?? 'Не удалось зарегистрироваться'}',
        ),
      );
      return;
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Не удалось зарегистрироваться',
        ),
      );
      return;
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.signOut();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
