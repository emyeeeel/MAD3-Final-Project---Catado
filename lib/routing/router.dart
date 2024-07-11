
import 'dart:async';

import 'package:finals/enum/auth_enum.dart';
import 'package:finals/screens/auth/signup_screen.dart';
import 'package:finals/screens/home/create_screen.dart';
import 'package:finals/screens/home/edit_profile_screen.dart';
import 'package:finals/screens/home/main_screens_wrapper.dart';
import 'package:finals/screens/home/notification_screen.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:finals/screens/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../controllers/auth_controller.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';

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

  FutureOr<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return HomeScreen.route;
      }
      if (state.matchedLocation == SignupScreen.route) {
        return HomeScreen.route;
      }
      return null;
    }
    if (AuthController.I.state != AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return null;
      }
      if (state.matchedLocation == SignupScreen.route) {
        return null;
      }
      return LoginScreen.route;
    }
    return null;
  }

  GlobalRouter(){
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: HomeScreen.route,
        redirect: handleRedirect,
        refreshListenable: AuthController.I,
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
            path: EditProfileScreen.route,
            name: EditProfileScreen.name,
            builder: (context, _) {
              return const EditProfileScreen();
          }),
          ShellRoute(
              navigatorKey: _shellNavigatorKey,
              routes: [
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: HomeScreen.route,
                    name: HomeScreen.name,
                    builder: (context, _) {
                      return const HomeScreen();
                    }),
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: SearchScreen.route,
                    name: SearchScreen.name,
                    builder: (context, _) {
                      return const SearchScreen();
                  }),
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: CreateScreen.route,
                    name: CreateScreen.name,
                    builder: (context, _) {
                      return const CreateScreen();
                  }),
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: NotificationScreen.route,
                    name: NotificationScreen.name,
                    builder: (context, _) {
                      return const NotificationScreen();
                  }),
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: ProfileScreen.route,
                    name: ProfileScreen.name,
                    builder: (context, _) {
                      return const ProfileScreen();
                  }),
              ],
              builder: (context, state, child) {
                return Wrapper(
                  child: child,
                );
          }),
    ]);
  }
}