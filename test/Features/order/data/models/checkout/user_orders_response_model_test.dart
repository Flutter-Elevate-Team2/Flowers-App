import 'package:flowers_app/Features/order/data/models/checkout/user_orders_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/orders_metadata_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserOrdersResponseModel Tests', () {


     test('toJson should return a valid Map representation', () {
      // Arrange
      final metadata = Metadata(totalPages: 5, currentPage: 1, limit: 10);
      final orders = [
        Orders(id: 'order_1', totalPrice: 250, orderNumber: 'ORD-101')
      ];
      final model = UserOrdersResponseModel(
        message: 'success',
        metadata: metadata,
        orders: orders,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['message'], 'success');
       expect(json['metadata'], isA<Metadata>());
      expect(json['orders'], isA<List<Orders>>());
      expect((json['orders'] as List<Orders>).first.orderNumber, 'ORD-101');
    });

    test('should handle empty or null orders list gracefully', () {
      // Act
      final json = {
        'message': 'no orders found',
        'metadata': null,
        'orders': []
      };
      final result = UserOrdersResponseModel.fromJson(json);

      // Assert
      expect(result.orders, isEmpty);
      expect(result.metadata, isNull);
    });
  });
}