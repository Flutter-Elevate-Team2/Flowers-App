 import 'package:flowers_app/Features/order/data/models/checkout/credit/customer_details_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomerDetails Model Tests', () {

    test('fromJson should handle mixed dynamic types correctly', () {
       final json = {
        'email': 'test@example.com',
        'name': 'John Doe', // String
        'address': {'city': 'Cairo', 'street': 'Tahrir'}, // Map
        'phone': null,
        'tax_exempt': 'none'
      };

      // Act
      final result = CustomerDetails.fromJson(json);

      // Assert
      expect(result.email, 'test@example.com');
      expect(result.name, 'John Doe');
      expect(result.address, isA<Map>());
      expect(result.address['city'], 'Cairo');
      expect(result.taxExempt, 'none');
    });

    test('toJson should preserve the dynamic data structure', () {
      // Arrange
      final customer = CustomerDetails(
          email: 'dev@flutter.com',
          name: {'first': 'Ahmed', 'last': 'Ali'}, // تمرير Map لحقل dynamic
          phone: '0123456789',
          taxExempt: 'exempt'
      );

      // Act
      final json = customer.toJson();

      // Assert
      expect(json['email'], 'dev@flutter.com');
      expect(json['name']['first'], 'Ahmed');
      expect(json['phone'], '0123456789');
      expect(json['tax_exempt'], 'exempt');
    });

    test('should handle completely empty JSON', () {
      // Act
      final result = CustomerDetails.fromJson({});

      // Assert
      expect(result.email, isNull);
      expect(result.name, isNull);
      expect(result.taxIds, isNull);
    });
  });
}