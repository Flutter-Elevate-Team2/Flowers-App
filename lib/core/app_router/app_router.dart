

import 'package:flowers_app/Features/auth/presentation/sign_up/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ====== Define all routes and route names ======
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

/// ====== Main App Router ======
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.signUpPath,
    routes: [
      /// ====== LOGIN SCREEN ======
      // GoRoute(
      //   path: Routes.signInPath,
      //   name: Routes.signInName,

      // ),

      /// ====== SIGN UP SCREEN ======
      GoRoute(
        path: Routes.signUpPath,
        name: Routes.signUpName,
        builder: (context, state) => const SignUpScreen(),
      ),
      /// ====== FORGET PASSWORD SCREEN ======
          // GoRoute(
          //   path: Routes.forgetPasswordPath,
          //   name: Routes.forgetPasswordName,
          // ),
      /// ====== HOME SCREEN ======
      GoRoute(
        path: Routes.homePath,
        name: Routes.homeName,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Home Screen')),
      ),
      ),
    ],
  );
}
