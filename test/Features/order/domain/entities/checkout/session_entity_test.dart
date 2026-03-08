import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';
 import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SessionEntity Tests', () {
    test('Should support value equality', () {
      // Arrange
      const entity1 = SessionEntity(id: 'sess_123', currency: 'usd', amountTotal: 1000);
      const entity2 = SessionEntity(id: 'sess_123', currency: 'usd', amountTotal: 1000);

      // Assert
      expect(entity1, equals(entity2));
    });

    test('Should be different when properties change', () {
      // Arrange
      const entity1 = SessionEntity(id: 'sess_123', amountTotal: 1000);
      const entity2 = SessionEntity(id: 'sess_456', amountTotal: 1000);

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      const initialEntity = SessionEntity(
        id: 'old_id',
        currency: 'egp',
        status: 'open',
      );

      // Act
        final updatedEntity = initialEntity.copyWith(
        'user_1',
        [], // orderItems
        500, // totalPrice
        'card',
        true,
        false,
        'processing',
        'new_id', //   الـ id
        '2026-01-01',
        '2026-01-02',
        'ORD-99',
      );

      // Assert
      expect(updatedEntity.id, 'new_id');
      expect(updatedEntity.currency, initialEntity.currency); // القيم التي لم تشملها الميثود تظل كما هي
    });
  });
}