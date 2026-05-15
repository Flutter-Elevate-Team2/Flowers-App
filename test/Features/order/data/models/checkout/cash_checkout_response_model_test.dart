import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CashCheckoutResponseModel & Order Tests', () {

    final tCartItemJson = {
      '_id': 'item123',
      'price': 50,
      'quantity': 2,
    };

    final tOrderJson = {
      '_id': 'order_sh_1',
      'user': 'user_001',
      'totalPrice': 100,
      'paymentType': 'cash',
      'orderNumber': 'ORD-5566',
      'orderItems': [tCartItemJson],
    };

    final tResponseJson = {
      'message': 'success',
      'order': tOrderJson,
    };

    test('fromJson should parse nested Order and CartItems correctly', () {
      final result = CashCheckoutResponseModel.fromJson(tResponseJson);

      expect(result.message, 'success');
      expect(result.order, isA<Order>());
      expect(result.order?.id, 'order_sh_1');
      expect(result.order?.orderItems?.first.id, 'item123');
    });

    test('toJson should return correct data', () {
      final item = CartItem(id: 'item123', price: 50, quantity: 2);
      final order = Order(
        id: 'order_sh_1',
        totalPrice: 100,
        orderItems: [item],
        orderNumber: 'ORD-5566',
      );
      final response = CashCheckoutResponseModel(message: 'success', order: order);

      final json = response.toJson();

      expect(json['message'], 'success');

       expect(json['order'], isA<Order>());
      final orderResult = json['order'] as Order;
      expect(orderResult.id, 'order_sh_1');
      expect(orderResult.orderNumber, 'ORD-5566');
    });
  });
}