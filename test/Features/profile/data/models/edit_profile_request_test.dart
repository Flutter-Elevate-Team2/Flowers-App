import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileRequest Model Tests', () {

    test('should convert to a valid JSON map with all fields provided', () {
      final request = EditProfileRequest(
        firstName: 'Ahmed',
        lastName: 'Ali',
        email: 'ahmed@example.com',
        phone: '0123456789',
      );

      final result = request.toJson();

      expect(result['firstName'], 'Ahmed');
      expect(result['lastName'], 'Ali');
      expect(result['email'], 'ahmed@example.com');
      expect(result['phone'], '0123456789');
    });

    test('should handle null values in JSON correctly', () {
      final request = EditProfileRequest(
        firstName: 'Ahmed',
        lastName: null,
        email: null,
        phone: null,
      );

      final result = request.toJson();

      expect(result['firstName'], 'Ahmed');
      expect(result['lastName'], isNull);
      expect(result['email'], isNull);
      expect(result['phone'], isNull);
    });

    test('should return empty keys when no data is provided in constructor', () {
      final request = EditProfileRequest();

      final result = request.toJson();

      expect(result['firstName'], isNull);
      expect(result['lastName'], isNull);
      expect(result['email'], isNull);
      expect(result['phone'], isNull);
    });
  });
}