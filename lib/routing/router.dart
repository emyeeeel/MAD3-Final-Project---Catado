
import 'package:finals/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login_screen.dart';
import '../screens/home/home.dart';

class GlobalRouter{
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  // Static getter to access the instance through GetIt
  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  GlobalRouter(){
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: HomeScreen.route,
        // redirect: handleRedirect,
        // refreshListenable: AuthController.I,
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: LoginScreen.route,
            name: LoginScreen.name,
            builder: (context, _) {
              return const LoginScreen();
          }),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: SignupScreen.route,
            name: SignupScreen.name,
            builder: (context, _) {
              return const SignupScreen();
          }),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: HomeScreen.route,
            name: HomeScreen.name,
            builder: (context, _) {
              return const HomeScreen();
          }),
    ]);
  }
}