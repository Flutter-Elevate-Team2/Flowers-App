import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorStrings Constants Tests', () {

    test('Network error constants should have correct values', () {
      expect(ErrorStrings.noInternet, "NO_INTERNET");
      expect(ErrorStrings.connectionTimeout, "CONNECTION_TIMEOUT");
      expect(ErrorStrings.sendTimeout, "SEND_TIMEOUT");
      expect(ErrorStrings.receiveTimeout, "RECEIVE_TIMEOUT");
    });

    test('HTTP Status code constants should have correct values', () {
      expect(ErrorStrings.badRequest, "BAD_REQUEST");
      expect(ErrorStrings.unauthorized, "UNAUTHORIZED");
      expect(ErrorStrings.notFound, "NOT_FOUND");
      expect(ErrorStrings.internalServerError, "INTERNAL_SERVER_ERROR");
    });

    test('Firebase Auth error constants should have correct values', () {
      expect(ErrorStrings.firebaseUserNotFound, "FIREBASE_USER_NOT_FOUND");
      expect(ErrorStrings.firebaseWrongPassword, "FIREBASE_WRONG_PASSWORD");
      expect(ErrorStrings.firebaseTooManyRequests, "FIREBASE_TOO_MANY_REQUESTS");
    });

    test('Fallback error constants should have correct values', () {
      expect(ErrorStrings.defaultError, "DEFAULT_ERROR");
      expect(ErrorStrings.unknownError, "UNKNOWN_ERROR");
    });

    test('Local storage error constants should have correct values', () {
      expect(ErrorStrings.hiveError, "HIVE_ERROR");
      expect(ErrorStrings.platformError, "PLATFORM_ERROR");
    });
  });

  group('ErrorStrings Integrity Tests', () {
    test('Constants should not be empty strings', () {
      // Logic check to ensure no developer accidentally cleared a string
      expect(ErrorStrings.networkError.isNotEmpty, true);
      expect(ErrorStrings.parsingError.isNotEmpty, true);
    });

    test('All constants should be unique (no duplicate values)', () {
      // This is a great test for error classes to ensure distinct error tracking
      final allValues = [
        ErrorStrings.noInternet,
        ErrorStrings.connectionTimeout,
        ErrorStrings.badRequest,
        ErrorStrings.unauthorized,
        ErrorStrings.firebaseUserNotFound,
        ErrorStrings.defaultError,
        // Add more if you want exhaustive checking
      ];

      final uniqueValues = allValues.toSet();
      expect(allValues.length, uniqueValues.length,
          reason: "Found duplicate string values in ErrorStrings constants");
    });
  });
}