import 'package:finals/controllers/auth_controller.dart';
import 'package:finals/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'routing/router.dart';

Future<void> main() async {

  AuthController.initialize();
  GlobalRouter.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  await AuthController.I.loadSession();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GlobalRouter.I.router,
      title: 'Mobile 3 - Final Project',
    );
  }
}
