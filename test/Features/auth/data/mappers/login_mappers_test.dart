import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/data/mappers/login_mappers.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';

void main() {
  group('Login Mapper Tests', () {

    test('should map LoginResponse to LoginEntity correctly', () {
      // Arrange
      final loginResponse = LoginResponse(
        message: 'success',
        token: 'token',
        user: null,
      );

      // Act
      final result = loginResponse.toEntity();

      // Assert
      expect(result, isA<LoginEntity>());
      expect(result.message, 'success');
      expect(result.token, 'token');
      expect(result.user, null);
    });

    test('should map User model to LoginUserEntity correctly', () {
      // Arrange
      final userModel = User(
        Id: '123',
        firstName: 'Malak',
        lastName: 'Hussein',
        email: 'malak@gmail.com',
        gender: 'female',
        phone: '010',
        photo: 'photo.png',
        role: 'user',
        createdAt: '2024-01-01',
      );

      // Act
      final result = userModel.toEntity();

      // Assert
      expect(result, isA<LoginUserEntity>());
      expect(result.id, '123');
      expect(result.firstName, 'Malak');
      expect(result.lastName, 'Hussein');
      expect(result.email, 'malak@gmail.com');
      expect(result.gender, 'female');
      expect(result.phone, '010');
      expect(result.photo, 'photo.png');
      expect(result.role, 'user');
      expect(result.createdAt, '2024-01-01');
    });

    test('should map null User fields to default values', () {
      // Arrange
      final userModel = User();

      // Act
      final result = userModel.toEntity();

      // Assert
      expect(result.id, ' ');
      expect(result.firstName, ' ');
      expect(result.lastName, ' ');
      expect(result.email, ' ');
      expect(result.gender, ' ');
      expect(result.phone, ' ');
      expect(result.photo, ' ');
      expect(result.role, ' ');
      expect(result.createdAt, ' ');
    });

  });
}
