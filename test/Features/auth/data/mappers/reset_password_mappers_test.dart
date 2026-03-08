import 'package:flowers_app/Features/auth/data/mappers/reset_password_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/reset_password_response/reset_password_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResetPasswordMapper Unit Tests', () {
    test('should map ResetPasswordResponse to ResetPasswordEntity correctly', () {
      // Arrange
      final response = ResetPasswordResponse(
        message: "Success",
        token: "test_token_123",
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity.message, "Success");
      expect(entity.token, "test_token_123");
    });

    test('should return default empty strings when response fields are null', () {
      // Arrange
      final response = ResetPasswordResponse(
        message: null,
        token: null,
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity.message, "");
      expect(entity.token, "");
    });
  });
}