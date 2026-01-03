import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/views/forget_password_screen_flow.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/views/login_screen.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/views/sign_up_screen.dart';
import 'package:flowers_app/Features/home/presentation/views/screens/home_screen.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String signInPath = '/signin';
  static const String signInName = 'signIn';

  static const String signUpPath = '/signup';
  static const String signUpName = 'signUp';

  static const String forgetPasswordPath = '/forgetpassword';
  static const String forgetPasswordName = 'forgetPassword';

  static const String homePath = '/home';
  static const String homeName = 'home';
}

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.signInPath,

    redirect: (context, state) async {
      final authRepo = getIt<AuthRepoContract>();

      final bool isLoggedIn = await authRepo.isLoggedIn();

      final bool isLoggingIn = state.uri.toString() == Routes.signInPath;

      if (isLoggedIn && isLoggingIn) {
        return Routes.homePath;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: Routes.signInPath,
        name: Routes.signInName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signUpPath,
        name: Routes.signUpName,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: Routes.forgetPasswordPath,
        name: Routes.forgetPasswordName,
        builder: (context, state) => const ForgetPasswordScreenFlow(),
      ),
      GoRoute(
        path: Routes.homePath,
        name: Routes.homeName,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
