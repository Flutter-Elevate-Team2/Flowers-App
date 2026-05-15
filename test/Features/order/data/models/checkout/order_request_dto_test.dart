import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderRequest Model Tests', () {

     final tShippingAddressJson = {
      'street': '90th Street',
      'city': 'Cairo',
      'phone': '0123456789',
      'username': 'ahmed_ali', // هذا هو الحقل المرجح نقصه بناءً على الـ Exception
    };

    final tOrderRequestJson = {
      'shippingAddress': tShippingAddressJson,
    };


    test('toJson should return OrderRequest with nested ShippingAddressRequest object', () {
      // Arrange
      final shippingAddress = ShippingAddressRequest(
        street: '90th Street',
        city: 'Cairo',
        phone: '0123456789', lat: '', long: '',
       );
      final orderRequest = OrderRequest(shippingAddress: shippingAddress);

      // Act
      final json = orderRequest.toJson();

      // Assert
      expect(json['shippingAddress'], isA<ShippingAddressRequest>());
      final actualAddress = json['shippingAddress'] as ShippingAddressRequest;
      expect(actualAddress.street, '90th Street');
    });
  });
}