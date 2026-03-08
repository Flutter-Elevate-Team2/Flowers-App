import 'package:flowers_app/Features/auth/data/mappers/verify_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/verify_password_response/verify_password_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VerifyPasswordMapper Unit Tests', () {
    test('should map VerifyPasswordResponse to VerifyPasswordEntity correctly', () {
      // Arrange
      final response = VerifyPasswordResponse(
        status: "Verified",
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity.status, "Verified");
    });

    test('should return empty string when status is null', () {
      // Arrange
      final response = VerifyPasswordResponse(
        status: null,
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity.status, "");
    });
  });
}