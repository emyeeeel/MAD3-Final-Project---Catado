
import 'dart:async';

import 'package:finals/enum/auth_enum.dart';
import 'package:finals/screens/auth/signup_screen.dart';
import 'package:finals/screens/home/create_screen.dart';
import 'package:finals/screens/home/edit_bio.dart';
import 'package:finals/screens/home/edit_name.dart';
import 'package:finals/screens/home/edit_profile_screen.dart';
import 'package:finals/screens/home/edit_username.dart';
import 'package:finals/screens/home/main_screens_wrapper.dart';
import 'package:finals/screens/home/reels_screen.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:finals/screens/home/search_screen.dart';
import 'package:finals/screens/home/settings_screen.dart';
import 'package:finals/screens/home/showList_post.dart';
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
      return state.matchedLocation;
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
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: EditName.route,
            name: EditName.name,
            builder: (context, _) {
              return const EditName();
          }),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: EditUsername.route,
            name: EditUsername.name,
            builder: (context, _) {
              return const EditUsername();
          }),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: EditBio.route,
            name: EditBio.name,
            builder: (context, _) {
              return const EditBio();
          }),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: SettingsScreen.route,
            name: SettingsScreen.name,
            builder: (context, _) {
              return const SettingsScreen();
          }),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: ShowUserPostsScreen.route,
            name: ShowUserPostsScreen.name,
            builder: (context, _) {
              return const ShowUserPostsScreen();
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
                    path: ReelsScreen.route,
                    name: ReelsScreen.name,
                    builder: (context, _) {
                      return const ReelsScreen();
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