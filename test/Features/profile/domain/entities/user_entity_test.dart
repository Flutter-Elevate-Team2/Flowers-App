import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';

void main() {
  group('UserEntity Equality Tests', () {
    const tUser1 = UserEntity(
      id: '1',
      firstName: 'Fatma',
      lastName: 'Saeed',
      email: 'test@test.com',
      phone: '0123456',
      photoUrl: 'url',
      role: 'user',
      gender: 'female',
    );

    const tUser2 = UserEntity(
      id: '1',
      firstName: 'Fatma',
      lastName: 'Saeed',
      email: 'test@test.com',
      phone: '0123456',
      photoUrl: 'url',
      role: 'user',
      gender: 'female',
    );

    test('should be equal when properties are identical', () {
      // Assert
      expect(tUser1, equals(tUser2));
    });

    test('should NOT be equal when a property is different', () {
      // Arrange
      const tUserDifferent = UserEntity(
        id: '2', // Id مختلف
        firstName: 'Fatma',
        lastName: 'Saeed',
        email: 'test@test.com',
        phone: '0123456',
        photoUrl: 'url',
        role: 'user',
        gender: 'female',
      );

      // Assert
      expect(tUser1, isNot(equals(tUserDifferent)));
    });
  });
}