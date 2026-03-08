import 'package:flowers_app/Features/order/domain/entities/checkout/shipping_address_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShippingAddressEntity Equality Tests', () {
    test('should return true when two entities have identical values', () {
      // Arrange
      const address1 = ShippingAddressEntity(
        street: 'El-Tahrir St',
        city: 'Cairo',
        phone: '0123456789',
        lat: '30.0',
        long: '31.0',
      );
      const address2 = ShippingAddressEntity(
        street: 'El-Tahrir St',
        city: 'Cairo',
        phone: '0123456789',
        lat: '30.0',
        long: '31.0',
      );

      // Assert
      expect(address1, equals(address2));
    });

    test('should return false when street is different', () {
      const address1 = ShippingAddressEntity(street: 'Street A');
      const address2 = ShippingAddressEntity(street: 'Street B');

      expect(address1, isNot(equals(address2)));
    });
  });
}