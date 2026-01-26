import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/views/forget_password_screen_flow.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/views/login_screen.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/views/sign_up_screen.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/best_seller_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/views/screens/home_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/home/views/screens/product_details_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/home_screen_body.dart';
import 'package:flowers_app/Features/commerce/presentation/products/views/screens/best_seller_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/products/views/screens/categories_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/products/views/screens/occasions_screen.dart';
import 'package:flowers_app/Features/order/presentation/cart/views/cart_screen.dart';
import 'package:flowers_app/Features/profile/presentation/views/edit_profile_screen.dart';
import 'package:flowers_app/Features/profile/presentation/views/profile_screen.dart';
import 'package:flowers_app/Features/profile/presentation/views/reset_password_screen.dart';
import 'package:flowers_app/Features/user_address/presentation/views/screens/add_address_screen.dart';
import 'package:flowers_app/Features/user_address/presentation/views/screens/saved_address_screen.dart';
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
  static const String resetPasswordPath = '/resetpassword';
  static const String resetPasswordName = 'resetPassword';
  static const String editProfilePath = '/editprofile';
  static const String editProfileName = 'editProfile';

  static const String savedAddressPath = '/savedAddress';
  static const String savedAddressName = 'savedAddress';
  static const String addAddressPath = '/addaddress';
  static const String addAddressName = 'addAddress';
}

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
    initialLocation: Routes.savedAddressPath,
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
                builder: (context, state) => const CartScreen(),
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
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      /// ====== BEST SELLER SCREEN ======
      GoRoute(
        path: Routes.bestSellerPath,
        name: Routes.bestSellerName,
        builder: (context, state) {
          final bestSellers = state.extra as List<BestSellerEntity>?;
          return BestSeller(bestSellers: bestSellers);
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

      /// ====== RESET PASSWORD SCREEN ======
      GoRoute(
        path: Routes.resetPasswordPath,
        name: Routes.resetPasswordName,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: Routes.editProfilePath,
        name: Routes.editProfileName,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: Routes.savedAddressPath,
        name: Routes.savedAddressName,
        builder: (context, state) => const SavedAddressScreen(),
      ),
      GoRoute(
        path: Routes.addAddressPath,
        name: Routes.addAddressName,
        builder: (context, state) => const AddAddressScreen(),
      ),
    ],
  );
}
