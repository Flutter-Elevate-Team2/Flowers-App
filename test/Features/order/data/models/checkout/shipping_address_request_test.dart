import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShippingAddressRequest DTO Tests', () {

    test('should parse from JSON correctly', () {
      final json = {
        'street': '90th Street',
        'phone': '01000000000',
        'city': 'New Cairo',
        'lat': '30.0123',
        'long': '31.4567',
      };

      final result = ShippingAddressRequest.fromJson(json);

      expect(result.street, '90th Street');
      expect(result.phone, '01000000000');
      expect(result.city, 'New Cairo');
    });

    test('should convert object to valid JSON for API request', () {
      final request = ShippingAddressRequest(
        street: 'El-Tahrir',
        phone: '0123456789',
        city: 'Cairo',
        lat: '30.0',
        long: '31.0',
      );

      final json = request.toJson();

       expect(json['street'], 'El-Tahrir');
      expect(json['phone'], '0123456789');
      expect(json['city'], 'Cairo');
      expect(json['lat'], '30.0');
      expect(json['long'], '31.0');
    });

    test('should throw an error if a required field is missing in JSON', () {
      final json = {
        'street': 'Missing other fields',
       };

       expect(() => ShippingAddressRequest.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}