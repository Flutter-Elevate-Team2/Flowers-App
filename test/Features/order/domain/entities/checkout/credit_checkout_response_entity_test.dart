import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreditCheckoutResponseEntity Tests', () {
    const tMessage = 'Success';
    const tSession = SessionEntity(url: 'https://stripe.com/checkout');
    const tOrder = OrderEntity(); // Used in current copyWith signature

    test('should support value equality via Equatable', () {
      // Arrange
      const entity1 = CreditCheckoutResponseEntity(message: tMessage, session: tSession);
      const entity2 = CreditCheckoutResponseEntity(message: tMessage, session: tSession);

      // Assert
      expect(entity1, equals(entity2));
    });

    test('props should contain message and session', () {
      // Arrange
      const entity = CreditCheckoutResponseEntity(message: tMessage, session: tSession);

      // Assert
      expect(entity.props, [tMessage, tSession]);
    });

    test('copyWith should return instance with new message but keep old session', () {
      // Arrange
      const initialEntity = CreditCheckoutResponseEntity(message: 'old', session: tSession);
      const newMessage = 'new message';

      // Act
      // Note: Your current code takes an OrderEntity but doesn't use it for the session
      final updatedEntity = initialEntity.copyWith(newMessage, tOrder);

      // Assert
      expect(updatedEntity.message, newMessage);
      expect(updatedEntity.session, tSession);
      expect(updatedEntity, isNot(initialEntity));
    });
  });
}