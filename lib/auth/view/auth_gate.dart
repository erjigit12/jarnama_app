import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarnama/auth/bloc/auth_bloc.dart';
import 'package:jarnama/auth/view/auth_page.dart';
import 'package:jarnama/home/page/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.unknown ||
            state.status == AuthStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == AuthStatus.authenticated) {
          return const MyHomePage();
        }

        return const AuthPage();
      },
    );
  }
}
