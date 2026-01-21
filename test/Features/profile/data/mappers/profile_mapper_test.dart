import 'package:flowers_app/Features/profile/data/mappers/profile_mapper.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/user_model.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileMapper Tests', () {
    test('toEntity should map ProfileDto to UserEntity correctly', () {
      // Arrange
      final userModel = UserModel(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phone: '1234567890',
        photo: 'url',
        role: 'admin',
        gender: 'Male',
      );
      final profileDto = ProfileDto(message: 'Success', user: userModel);

      // Act
      final entity = profileDto.toEntity();

      // Assert
      expect(entity, isA<UserEntity>());
      expect(entity.id, '1');
      expect(entity.firstName, 'John');
      expect(entity.lastName, 'Doe');
      expect(entity.email, 'john@example.com');
      expect(entity.phone, '1234567890');
      expect(entity.photoUrl, 'url');
      expect(entity.role, 'admin');
      expect(entity.gender, 'Male');
    });

    test('toEntity should handle null user logic', () {
      // Arrange
      final profileDto = ProfileDto(message: 'Success', user: null);

      // Act
      final entity = profileDto.toEntity();

      // Assert
      expect(entity, isA<UserEntity>());
      expect(entity.id, '');
      expect(entity.firstName, '');
      expect(entity.lastName, '');
      expect(entity.email, '');
      expect(entity.phone, '');
      expect(entity.photoUrl, '');
      expect(entity.role, 'user');
      expect(entity.gender, '');
    });
  });
}
