import 'package:flowers_app/Features/user_address/data/models/address_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressDto Serialization Tests', () {
     final mockJson = {
      '_id': 'addr_123',
      'street': '90th Street',
      'phone': '01012345678',
      'city': 'New Cairo',
      'lat': '30.0444',
      'long': '31.2357',
      'username': 'ahmed_dev'
    };

    test('fromJson should correctly map all fields including _id', () {
      // Act
      final address = AddressDto.fromJson(mockJson);

      // Assert
      expect(address.id, 'addr_123'); // التأكد من نجاح الـ @JsonKey(name: "_id")
      expect(address.street, '90th Street');
      expect(address.phone, '01012345678');
      expect(address.city, 'New Cairo');
      expect(address.lat, '30.0444');
      expect(address.long, '31.2357');
      expect(address.username, 'ahmed_dev');
    });

    test('toJson should return a map with correct keys including _id', () {
      // Arrange
      final address = AddressDto(
        id: 'addr_999',
        street: 'Tahrir',
        username: 'user1',
      );

      // Act
      final json = address.toJson();

      // Assert
      expect(json['_id'], 'addr_999'); // التأكد أن الـ Key رجع لـ _id مش id
      expect(json['street'], 'Tahrir');
      expect(json['username'], 'user1');
      // التأكد أن الحقول الـ null موجودة كـ keys وقيمتها null (أو حسب إعدادات JsonSerializable)
      expect(json.containsKey('phone'), true);
    });

    test('Should handle null values gracefully', () {
      // Act
      final address = AddressDto.fromJson({});

      // Assert
      expect(address.id, isNull);
      expect(address.street, isNull);
    });
  });
}