 import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditAddressRequest Serialization Tests', () {

    final mockJson = {
      'street': 'Street 10',
      'phone': '01122334455',
      'city': 'Alexandria',
      'lat': '31.2001',
      'long': '29.9187',
      'username': 'omar_dev'
    };

    test('fromJson should create a valid EditAddressRequest object', () {
      // Act
      final request = EditAddressRequest.fromJson(mockJson);

      // Assert
      expect(request.street, 'Street 10');
      expect(request.phone, '01122334455');
      expect(request.city, 'Alexandria');
      expect(request.lat, '31.2001');
      expect(request.long, '29.9187');
      expect(request.username, 'omar_dev');
    });

    test('toJson should return a Map with correct keys and values', () {
      // Arrange
      final request = EditAddressRequest(
        street: 'Nasr City',
        phone: '01000000000',
        city: 'Cairo',
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['street'], 'Nasr City');
      expect(json['phone'], '01000000000');
      expect(json['city'], 'Cairo');
      // التأكد أن الحقول التي لم تُمرر قيمتها null
      expect(json['username'], isNull);
    });

    test('Should handle empty JSON by returning null fields', () {
      // Act
      final request = EditAddressRequest.fromJson({});

      // Assert
      expect(request.street, isNull);
      expect(request.phone, isNull);
      expect(request.city, isNull);
    });

    test('Mutation: Should allow updating fields after creation', () {
      // Arrange
      final request = EditAddressRequest(street: 'Old Street');

      // Act
      request.street = 'New Street';

      // Assert
      expect(request.street, 'New Street');
    });
  });
}