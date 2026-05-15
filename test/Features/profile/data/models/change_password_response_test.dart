import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangePasswordResponse Model Tests', () {

    test('should return a valid model from json with all fields', () {
      final Map<String, dynamic> jsonMap = {
        'message': 'Password updated successfully',
        'token': 'some_random_token_123'
      };

      final result = ChangePasswordResponse.fromJson(jsonMap);

      expect(result.message, 'Password updated successfully');
      expect(result.token, 'some_random_token_123');
    });

    test('should return a valid model from json when token is null', () {
      final Map<String, dynamic> jsonMap = {
        'message': 'Password updated successfully',
        'token': null
      };

      final result = ChangePasswordResponse.fromJson(jsonMap);

      expect(result.message, 'Password updated successfully');
      expect(result.token, isNull);
    });

    test('should support equality or match data correctly', () {
      final response = ChangePasswordResponse(
          message: 'Success',
          token: 'token123'
      );

      expect(response.message, 'Success');
      expect(response.token, 'token123');
    });
  });
}