import 'package:flowers_app/Features/profile/data/mappers/change_password_mapper.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangePasswordMapper Tests', () {
    test(
      'toEntity should map ChangePasswordResponse to ChangePasswordEntity correctly',
      () {
        // Arrange
        final response = ChangePasswordResponse(
          message: 'Success',
          token: 'token123',
        );

        // Act
        final entity = response.toEntity();

        // Assert
        expect(entity, isA<ChangePasswordEntity>());
        expect(entity.message, 'Success');
        expect(entity.token, 'token123');
      },
    );

    test('toEntity should map null token to empty string', () {
      // Arrange
      final response = ChangePasswordResponse(message: 'Success');

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity.token, '');
    });
  });
}
