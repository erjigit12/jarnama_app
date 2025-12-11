import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarnama/auth/bloc/auth_bloc.dart';
import 'package:jarnama/auth/data/auth_repository.dart';
import 'package:jarnama/auth/view/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    AuthRepository? repository,
    FirebaseFirestore? firestore,
  })  : _repository = repository,
        _firestore = firestore;

  final AuthRepository? _repository;
  final FirebaseFirestore? _firestore;

  @override
  Widget build(BuildContext context) {
    final authRepository = _repository ?? AuthRepository();
    final firestore = _firestore ?? FirebaseFirestore.instance;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<FirebaseFirestore>.value(value: firestore),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(repository: authRepository),
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
