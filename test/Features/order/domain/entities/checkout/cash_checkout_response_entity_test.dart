import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

 @GenerateMocks([OrderEntity])
void main() {
  group('CashCheckoutResponseEntity Tests', () {
    const tMessage = 'Order placed successfully';
    const tOrder = OrderEntity(); // Replace with a real instance or mock if needed

    test('should support value equality via Equatable', () {
      // Arrange
      const entity1 = CashCheckoutResponseEntity(message: tMessage, order: tOrder);
      const entity2 = CashCheckoutResponseEntity(message: tMessage, order: tOrder);

      // Assert
      expect(entity1, equals(entity2));
    });

    test('props should contain message and order', () {
      // Arrange
      const entity = CashCheckoutResponseEntity(message: tMessage, order: tOrder);

      // Assert
      expect(entity.props, [tMessage, tOrder]);
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      const initialEntity = CashCheckoutResponseEntity(message: 'old', order: tOrder);
      const newMessage = 'new message';

      // Act
      final updatedEntity = initialEntity.copyWith(newMessage, tOrder);

      // Assert
      expect(updatedEntity.message, newMessage);
      expect(updatedEntity.order, tOrder);
      expect(updatedEntity, isNot(initialEntity)); // Ensure it's a different instance
    });

    test('should work with null values if provided', () {
      // Arrange
      const entity = CashCheckoutResponseEntity(message: null, order: null);

      // Assert
      expect(entity.message, isNull);
      expect(entity.order, isNull);
    });
  });
}