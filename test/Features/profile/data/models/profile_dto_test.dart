import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/user_model.dart';

void main() {
  group('ProfileDto & UserModel Tests', () {

    final tUserModelJson = {
      '_id': '123',
      'firstName': 'Fatma',
      'email': 'test@test.com',
      'createdAt': '2024-03-08T10:00:00.000Z',
    };

    final tProfileDtoJson = {
      'message': 'success',
      'user': tUserModelJson,
    };

    test('should return a valid UserModel from JSON', () {
      // Act
      final result = UserModel.fromJson(tUserModelJson);

      // Assert
      expect(result.id, '123');
      expect(result.firstName, 'Fatma');
      expect(result.createdAt, isA<DateTime>());
    });

    test('should return a valid ProfileDto from JSON', () {
      // Act
      final result = ProfileDto.fromJson(tProfileDtoJson);

      // Assert
      expect(result.message, 'success');
      expect(result.user?.id, '123');
    });

    test('toJson should return a proper Map containing the data', () {
      // Arrange
      final model = UserModel(id: '123', firstName: 'Fatma');

      // Act
      final result = model.toJson();

      // Assert
      expect(result['_id'], '123');
      expect(result['firstName'], 'Fatma');
    });
  });
}