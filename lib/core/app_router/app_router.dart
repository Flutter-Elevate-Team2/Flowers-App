import 'package:flowers_app/Features/home/presentation/views/screens/best_seller_screen.dart';
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

  static const String bestSellerPath = '/bestseller';
  static const String bestSellerName = 'bestSeller';
}

/// ====== Main App Router ======
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.bestSellerPath,
    routes: [
      /// ====== LOGIN SCREEN ======
      GoRoute(
        path: Routes.signInPath,
        name: Routes.signInName,
        // Fix: Added builder (Replace SizedBox with SignInScreen)
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== SIGN UP SCREEN ======
      GoRoute(
        path: Routes.signUpPath,
        name: Routes.signUpName,
        // Fix: Added builder (Replace SizedBox with SignUpScreen)
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== FORGET PASSWORD SCREEN ======
      GoRoute(
        path: Routes.forgetPasswordPath,
        name: Routes.forgetPasswordName,
        // Fix: Added builder (Replace SizedBox with ForgetPasswordScreen)
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== HOME SCREEN ======
      GoRoute(
        path: Routes.homePath,
        name: Routes.homeName,
        // Fix: Added builder (Replace SizedBox with HomeScreen)
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== BEST SELLER SCREEN ======
      GoRoute(
        path: Routes.bestSellerPath,
        name: Routes.bestSellerName,
        // Fix: Added builder (Replace SizedBox with BestSellerScreen)
        builder: (context, state) => const BestSeller(),
      ),
    ],
  );
}
