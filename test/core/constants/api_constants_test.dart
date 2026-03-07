import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Ensure the Flutter test binding is ready
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiConstants Tests', () {

    setUpAll(() async {
      // 1. Load from a string to initialize the internal state of DotEnv
      // This satisfies the 'NotInitializedError'
      await dotenv.load(mergeWith: {'BASE_URL': 'https://api.flowers.com'});

      // 2. Force the static variable to update with the mocked value
      ApiConstants.apiBaseUrl = dotenv.env['BASE_URL'] ?? "";
    });

    test('apiBaseUrl should load correctly from environment', () {
      expect(ApiConstants.apiBaseUrl, "https://api.flowers.com");
    });

    test('Auth endpoints should match the defined strings', () {
      expect(ApiConstants.signIn, "/auth/signin");
      expect(ApiConstants.signUp, "/auth/signup");
      expect(ApiConstants.logout, "/auth/logout");
    });

    test('Pagination defaults should be set correctly', () {
      expect(ApiConstants.defaultLimit, 40);
      expect(ApiConstants.defaultCurrentPage, 1);
    });

    test('Order status constants should be correct', () {
      expect(ApiConstants.pending, "pending");
      expect(ApiConstants.completed, "completed");
    });
  });
}