import 'package:flowers_app/Features/home/domain/entities/home_entities/bestseller_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/products/presentation/views/screens/best_seller_screen.dart';
import 'package:flowers_app/Features/home/presentation/views/screens/home_screen.dart';
import 'package:flowers_app/Features/home/presentation/views/screens/product_details_screen.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_screen_body.dart';
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

  // Home Tabs Paths
  static const String homePath = '/home';
  static const String homeName = 'home';

  static const String categoriesPath = '/categories';
  static const String categoriesName = 'categories';

  static const String cartPath = '/cart';
  static const String cartName = 'cart';

  static const String profilePath = '/profile';
  static const String profileName = 'profile';
  static const String occasionPath = '/occasion';
  static const String occasionName = 'occasion';

  static const String categoryPath = '/category';
  static const String categoryName = 'category';
  static const String productDetailsPath = '/productdetails';
  static const String productDetailsName = 'productdetails';
  static const String bestSellerPath = '/bestseller';
  static const String bestSellerName = 'bestSeller';
}

/// ====== Main App Router ======
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _homeNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _categoriesNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _cartNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _profileNavigatorKey =
  GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.homePath,
    routes: [
      /// ====== LOGIN SCREEN ======
      GoRoute(
        path: Routes.signInPath,
        name: Routes.signInName,
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== SIGN UP SCREEN ======
      GoRoute(
        path: Routes.signUpPath,
        name: Routes.signUpName,
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== FORGET PASSWORD SCREEN ======
      GoRoute(
        path: Routes.forgetPasswordPath,
        name: Routes.forgetPasswordName,
        builder: (context, state) => const SizedBox(),
      ),

      /// ====== MAIN SHELL ROUTE (BOTTOM NAV BAR) ======
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.homePath,
                name: Routes.homeName,
                builder: (context, state) => const HomeScreenBody(),
              ),
            ],
          ),

          // Branch 2: Categories
          StatefulShellBranch(
            navigatorKey: _categoriesNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.categoriesPath,
                name: Routes.categoriesName,
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;
                  final categories =
                  extra?['categories'] as List<CategoryEntity>?;
                  final initialIndex = extra?['initialIndex'] as int? ?? 0;

                  return CategoriesScreen(
                    categories: categories,
                    initialIndex: initialIndex,
                  );
                },
              ),
            ],
          ),

          // Branch 3: Cart
          StatefulShellBranch(
            navigatorKey: _cartNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.cartPath,
                name: Routes.cartName,
                builder: (context, state) =>
                const Center(child: Text("Cart Screen")),
              ),
            ],
          ),

          // Branch 4: Profile
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.profilePath,
                name: Routes.profileName,
                builder: (context, state) =>
                const Center(child: Text("Profile Screen")),
              ),
            ],
          ),
        ],
      ),

      /// ====== BEST SELLER SCREEN ======
      GoRoute(
        path: Routes.bestSellerPath,
        name: Routes.bestSellerName,
        // Fix: Added builder (Replace SizedBox with BestSellerScreen)
        builder: (context, state) {
          final bestSellers = state.extra as List<BestSellerEntity>?;
          return BestSellerScreen(

          );
        },
      ),

      /// ====== OCCASIONS SCREEN ======
      GoRoute(
        path: Routes.occasionPath,
        name: Routes.occasionName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final occasions = extra?['occasions'] as List<OccasionEntity>?;
          final initialIndex = extra?['initialIndex'] as int? ?? 0;

          return OccasionsScreen(
            occasions: occasions,
            initialIndex: initialIndex,
          );
        },
      ),

      /// ====== PRODUCT DETAILS SCREEN ======
      GoRoute(
        path: Routes.productDetailsPath,
        name: Routes.productDetailsName,
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductDetailsScreen(product: product);
        },
      ),
    ],
  );
}