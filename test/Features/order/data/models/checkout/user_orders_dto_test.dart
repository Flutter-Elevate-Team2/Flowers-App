import 'package:flowers_app/Features/order/data/models/checkout/user_orders_dto.dart';
import 'package:flutter_test/flutter_test.dart';
 import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';

void main() {
  group('Orders DTO Serialization Tests', () {

    final tShippingJson = {
      'street': 'El-Tahrir St',
      'phone': '0123456789',
      'city': 'Cairo',
      'lat': '30.0',
      'long': '31.0',
    };

     final tOrderItemsJson = [
      {
        'product': {
          '_id': 'flower_123',
          'name': 'Rose',
          'price': 100,
         },
        'quantity': 2,
        'price': 200,
      }
    ];

    final tOrdersJson = {
      '_id': 'order_123',
      'shippingAddress': tShippingJson,
      'orderItems': tOrderItemsJson,
      'totalPrice': 200,
      'paymentType': 'card',
      'isPaid': true,
      'orderNumber': 'ORD-5566',
    };

    test('should parse Orders and its nested objects from JSON', () {
      final result = Orders.fromJson(tOrdersJson);

      expect(result.id, 'order_123');
      expect(result.shippingAddress, isA<ShippingAddressRequest>());
      expect(result.orderItems, isA<List<CartItem>>());
       expect(result.orderItems?.first.quantity, 2);
    });

    test('should convert Orders object to valid JSON', () {
      final shipping = ShippingAddressRequest(
          street: 'Street', phone: '011', city: 'Giza', lat: '1', long: '1'
      );
      final order = Orders(
        id: '999',
        shippingAddress: shipping,
        totalPrice: 500,
        orderItems: [],
      );

      final json = order.toJson();

      expect(json['_id'], '999');

     final shippingMap = (json['shippingAddress'] as ShippingAddressRequest).toJson();
      expect(shippingMap['city'], 'Giza');
    });
  });
}