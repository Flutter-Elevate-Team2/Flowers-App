import 'package:flowers_app/Features/order/domain/entities/checkout/adaptive_pricing_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptivePricingEntity Tests', () {
    test('should support value equality', () {
      // Arrange
      const entity1 = AdaptivePricingEntity(enabled: true);
      const entity2 = AdaptivePricingEntity(enabled: true);

      // Assert
      expect(entity1, equals(entity2));
    });

    test('should be equal when both enabled values are null', () {
      const entity1 = AdaptivePricingEntity(enabled: null);
      const entity2 = AdaptivePricingEntity(enabled: null);

      expect(entity1, equals(entity2));
    });

    test('should not be equal when values differ', () {
      const entity1 = AdaptivePricingEntity(enabled: true);
      const entity2 = AdaptivePricingEntity(enabled: false);

      expect(entity1, isNot(equals(entity2)));
    });
  });
}