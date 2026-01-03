import 'package:flowers_app/Features/home/presentation/views/screens/home_screen.dart';
import 'package:flowers_app/Features/home/presentation/views/screens/product_details_screen.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/presentation/views/screens/categories_screen.dart';
import 'package:flowers_app/Features/products/presentation/views/screens/occasions_screen.dart';
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

  static const String occasionPath = '/occasion';
  static const String occasionName = 'occasion';


  static const String categoryPath = '/category';
  static const String categoryName = 'category';
  static const String productDetailsPath = '/productdetails';
  static const String productDetailsName = 'productdetails';
}

/// ====== Main App Router ======
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.homePath,
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
        builder: (context, state) => const HomeScreen(),
      ),

      /// ====== Occasion SCREEN ======
      GoRoute(
        path: Routes.occasionPath,
        name: Routes.occasionName,
        // Fix: Added builder (Replace SizedBox with HomeScreen)
        builder: (context, state) => const OccasionsScreen(),
      ),

      /// ====== Category SCREEN ======
      GoRoute(
        path: Routes.categoryPath,
        name: Routes.categoryName,
        // Fix: Added builder (Replace SizedBox with HomeScreen)
        builder: (context, state) => const CategoriesScreen(),
      ),
      /// ====== PRODUCT DETAILS SCREEN ======
      GoRoute(
        path: Routes.productDetailsPath,
        name: Routes.productDetailsName,
        builder: (context, state) => ProductDetailsScreen(product: state.extra as ProductEntity),
      ),
    ],
  );
}
