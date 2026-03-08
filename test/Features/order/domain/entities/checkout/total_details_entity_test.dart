import 'package:flowers_app/Features/order/domain/entities/checkout/total_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TotalDetailsEntity Equality Tests', () {
    test('should return true when two entities have the same values', () {
      // Arrange
      final entity1 = TotalDetailsEntity(
        amountDiscount: 50,
        amountShipping: 20,
        amountTax: 5,
      );
      const entity2 = TotalDetailsEntity(
        amountDiscount: 50,
        amountShipping: 20,
        amountTax: 5,
      );

      // Assert
      expect(entity1, equals(entity2));
    });

    test('should return false when values are different', () {
      const entity1 = TotalDetailsEntity(amountDiscount: 50);
      const entity2 = TotalDetailsEntity(amountDiscount: 100);

      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle null values correctly in equality', () {
      const entity1 = TotalDetailsEntity(amountShipping: 10);
      const entity2 = TotalDetailsEntity(amountShipping: 10);

      expect(entity1, equals(entity2));
    });
  });
}