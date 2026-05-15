import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('Routes Constants', () {
    test('should have correct SignIn route paths', () {
      expect(Routes.signInPath, '/signin');
      expect(Routes.signInName, 'signIn');
    });

    test('should have correct ForgetPassword route paths', () {
      expect(Routes.forgetPasswordPath, '/forgetpassword');
      expect(Routes.forgetPasswordName, 'forgetPassword');
    });

    test('should have correct Home route paths', () {
      expect(Routes.homePath, '/home');
      expect(Routes.homeName, 'home');
    });

    test('should have correct Profile route paths', () {
      expect(Routes.profilePath, '/profile');
      expect(Routes.profileName, 'profile');
    });

    test('should have correct Cart route paths', () {
      expect(Routes.cartPath, '/cart');
      expect(Routes.cartName, 'cart');
    });

    test('should have correct Order route paths', () {
      expect(Routes.orderPath, '/order');
      expect(Routes.orderName, 'order');
    });
  });

  group('AppRouter Configuration', () {
    late GoRouter router;

    setUp(() {
      router = AppRouter.router;
    });

    test('should have rootNavigatorKey initialized', () {
      expect(AppRouter.rootNavigatorKey, isNotNull);
    });

    test('should have routes configured in the router', () {
      expect(router.configuration.routes, isNotEmpty);
    });

    test('should verify named locations match paths', () {
      // Testing a few core routes
      expect(router.namedLocation(Routes.signInName), Routes.signInPath);
      expect(router.namedLocation(Routes.signUpName), Routes.signUpPath);
      expect(router.namedLocation(Routes.homeName), Routes.homePath);
    });

    test('should have StatefulShellRoute configured for Bottom Navigation', () {
      final hasShellRoute = router.configuration.routes.any(
            (route) => route is StatefulShellRoute,
      );
      expect(hasShellRoute, isTrue);
    });

    test('should have exactly FOUR branches in StatefulShellRoute', () {
      final shellRoute = router.configuration.routes.firstWhere(
            (route) => route is StatefulShellRoute,
      ) as StatefulShellRoute;

      // Branches: Home, Categories, Cart, Profile
      expect(shellRoute.branches.length, equals(4));
    });

    test('should handle dynamic routes with parameters correctly', () {
      const orderId = 'test_123';

      // Verification of path with parameter
      final location = router.namedLocation(
        Routes.trackOrderName,
        pathParameters: {'orderId': orderId},
      );

      expect(location, contains(orderId));
      expect(location, equals('/trackorder/$orderId'));
    });
  });
}