import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrdersMetadata Entity Tests', () {
    test('should support value equality via Equatable', () {
      // Arrange
      const metadata1 = OrdersMetadata(
        currentPage: 1,
        totalPages: 5,
        limit: 10,
        totalItems: 50,
      );
      const metadata2 = OrdersMetadata(
        currentPage: 1,
        totalPages: 5,
        limit: 10,
        totalItems: 50,
      );

      // Assert
       expect(metadata1, equals(metadata2));
    });

    test('should not be equal when values differ', () {
      const metadata1 = OrdersMetadata(currentPage: 1);
      const metadata2 = OrdersMetadata(currentPage: 2);

      expect(metadata1, isNot(equals(metadata2)));
    });
  });
}