import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogoutResponse Model Tests', () {
    test('should return a valid model from json', () {
      final Map<String, dynamic> jsonMap = {
        'message': 'Logged out successfully'
      };

      final result = LogoutResponse.fromJson(jsonMap);

      expect(result.message, 'Logged out successfully');
    });

    test('should throw an error when message is missing from json', () {
      final Map<String, dynamic> jsonMap = {};

      expect(
            () => LogoutResponse.fromJson(jsonMap),
        throwsA(isA<TypeError>()),
      );
    });

    test('should correctly store message when created via constructor', () {
      final response = LogoutResponse(message: 'Success');
      expect(response.message, 'Success');
    });
    group('LogoutResponse Model Tests', () {
      test('should return a valid model from json', () {
        final Map<String, dynamic> jsonMap = {
          'message': 'Logged out successfully'
        };

        final result = LogoutResponse.fromJson(jsonMap);

        expect(result.message, 'Logged out successfully');
      });

      test('should throw an error when message is missing from json', () {
        final Map<String, dynamic> jsonMap = {};

        expect(
              () => LogoutResponse.fromJson(jsonMap),
          throwsA(isA<TypeError>()),
        );
      });

      test('should correctly store message when created via constructor', () {
        final response = LogoutResponse(message: 'Success');
        expect(response.message, 'Success');
      });
    });
  });
  }