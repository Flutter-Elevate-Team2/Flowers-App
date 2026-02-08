import 'package:flowers_app/Features/order/data/mappers/checkout/order_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(' Implement tests for order_mapper.dart', () {
      // Arrange
      final order = Order(
          id: '1',
          totalPrice: 100,
          user: "user",
          updatedAt: "",
          createdAt: "",
          orderItems: [],
          isPaid: false,
          isDelivered: false,
          state: 'pending',
          orderNumber: "ORD12345",
          paymentType: "cash",
      );

      // Act
      final entity = order.toEntity();

      // Assert
      expect(entity, isA<OrderEntity>());
      expect(entity.id, "1");
      expect(entity.totalPrice, 100);
      expect(entity.user, "user");
      expect(entity.updatedAt, "");
      expect(entity.createdAt, "");
      expect(entity.orderItems, []);
      expect(entity.isPaid, false);
      expect(entity.isDelivered, false);
      expect(entity.state, 'pending');
      expect(entity.orderNumber, "ORD12345");
      expect(entity.paymentType, "cash");
    });
}