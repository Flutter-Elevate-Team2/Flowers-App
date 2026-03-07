import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserOrdersResponseEntity Tests', () {
    const tMessage = 'Orders fetched successfully';

    // Mocking or using simple instances of nested entities
    const tMetadata = OrdersMetadata(currentPage: 1, totalPages: 5);
    final tOrders = [
      const OrdersEntity(id: '1', totalPrice: 100),
      const OrdersEntity(id: '2', totalPrice: 200),
    ];

    test('should support value equality via Equatable', () {
      // Arrange
      final entity1 = UserOrdersResponseEntity(
        message: tMessage,
        metadata: tMetadata,
        orders: tOrders,
      );
      final entity2 = UserOrdersResponseEntity(
        message: tMessage,
        metadata: tMetadata,
        orders: tOrders,
      );

      // Assert
      expect(entity1, equals(entity2));
    });

    test('props should contain message, metadata, and orders', () {
      // Arrange
      final entity = UserOrdersResponseEntity(
        message: tMessage,
        metadata: tMetadata,
        orders: tOrders,
      );

      // Assert
      expect(entity.props, [tMessage, tMetadata, tOrders]);
    });

    test('should be unequal when orders list content changes', () {
      // Arrange
      final entity1 = UserOrdersResponseEntity(
        message: tMessage,
        metadata: tMetadata,
        orders: [const OrdersEntity(id: '1')],
      );
      final entity2 = UserOrdersResponseEntity(
        message: tMessage,
        metadata: tMetadata,
        orders: [const OrdersEntity(id: '2')], // Different ID
      );

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle null values correctly', () {
      // Arrange
      const entity = UserOrdersResponseEntity(
        message: null,
        metadata: null,
        orders: null,
      );

      // Assert
      expect(entity.message, isNull);
      expect(entity.metadata, isNull);
      expect(entity.orders, isNull);
      expect(entity.props, [null, null, null]);
    });
  });
}