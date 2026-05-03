 import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderEntity Tests', () {
    const tId = 'order_123';
    const tTotalPrice = 1500;
    const tUser = 'user_99';
    const tPaymentType = 'cash';
    const tOrderNumber = 'ABC-555';

    test('should support value equality via Equatable', () {
      // Arrange
      const entity1 = OrderEntity(id: tId, totalPrice: tTotalPrice, orderNumber: tOrderNumber);
      const entity2 = OrderEntity(id: tId, totalPrice: tTotalPrice, orderNumber: tOrderNumber);

      // Assert
      expect(entity1, equals(entity2));
    });

    test('props should contain all fields for accurate state comparison', () {
      // Arrange
      const entity = OrderEntity(
        id: tId,
        totalPrice: tTotalPrice,
        user: tUser,
        paymentType: tPaymentType,
        isPaid: false,
        isDelivered: false,
        state: 'pending',
        orderItems: [],
        createdAt: '2023-01-01',
        updatedAt: '2023-01-02',
        orderNumber: tOrderNumber,
      );

      // Assert
      expect(entity.props.length, 11);
      expect(entity.props, [
        tId, tTotalPrice, tUser, tPaymentType, false, false, 'pending', [], '2023-01-01', '2023-01-02', tOrderNumber
      ]);
    });

    test('copyWith should return a new instance with provided values', () {
      // Arrange
      const initialOrder = OrderEntity(id: 'old_id', totalPrice: 100);

      // Act
      final updatedOrder = initialOrder.copyWith(
          'new_user', [], 500, 'credit', true, true, 'shipped', 'new_id', 'date1', 'date2', 'NEW-1'
      );

      // Assert
      expect(updatedOrder.id, 'new_id');
      expect(updatedOrder.totalPrice, 500);
      expect(updatedOrder.isPaid, true);
      expect(updatedOrder, isNot(initialOrder));
    });
  });
}