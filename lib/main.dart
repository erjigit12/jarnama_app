import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jarnama/app/app.dart';
import 'package:jarnama/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}
