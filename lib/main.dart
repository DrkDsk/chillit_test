import 'package:chillit_test/firebase_options.dart';
import 'package:chillit_test/src/core/di/di.dart';
import 'package:chillit_test/src/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await registerDependencies();

  runApp(const MyApp());
}
