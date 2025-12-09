import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarnama/auth/bloc/auth_bloc.dart';
import 'package:jarnama/auth/data/auth_repository.dart';
import 'package:jarnama/auth/view/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            AuthBloc(repository: context.read<AuthRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
            ),
            useMaterial3: false,
          ),
          home: const AuthGate(),
        ),
      ),
    );
  }
}
