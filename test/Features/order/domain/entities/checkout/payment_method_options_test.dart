import 'package:flowers_app/Features/order/domain/entities/checkout/payment_method_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentMethodOptionsEntity & Card Tests', () {

    test('Card should support value equality', () {
      // Arrange
      const card1 = Card(requestThreeDSecure: 'any');
      const card2 = Card(requestThreeDSecure: 'any');

      // Assert
      expect(card1, equals(card2));
    });

    test('PaymentMethodOptionsEntity should support deep value equality', () {
      // Arrange
      const options1 = PaymentMethodOptionsEntity(
        card: Card(requestThreeDSecure: 'always'),
      );
      const options2 = PaymentMethodOptionsEntity(
        card: Card(requestThreeDSecure: 'always'),
      );

      // Assert
      expect(options1, equals(options2));
    });

    test('Should be different when nested Card property changes', () {
      // Arrange
      const options1 = PaymentMethodOptionsEntity(
        card: Card(requestThreeDSecure: 'always'),
      );
      const options2 = PaymentMethodOptionsEntity(
        card: Card(requestThreeDSecure: 'never'),
      );

      // Assert
      expect(options1, isNot(equals(options2)));
    });

    test('Props should contain the correct nested objects', () {
      const card = Card(requestThreeDSecure: 'any');
      const options = PaymentMethodOptionsEntity(card: card);

      expect(options.props, [card]);
      expect(card.props, ['any']);
    });
  });
}