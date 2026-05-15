import 'package:flowers_app/Features/order/domain/entities/checkout/customer_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomerDetailsEntity Tests', () {
    test('Should support value equality', () {
      // Arrange
      const entity1 = CustomerDetailsEntity(
        email: 'test@example.com',
        name: 'Ahmed',
        phone: '0123456789',
      );
      const entity2 = CustomerDetailsEntity(
        email: 'test@example.com',
        name: 'Ahmed',
        phone: '0123456789',
      );

      // Assert
       expect(entity1, equals(entity2));
    });

    test('Should be different when a property is changed', () {
      // Arrange
      const entity1 = CustomerDetailsEntity(email: 'a@test.com');
      const entity2 = CustomerDetailsEntity(email: 'b@test.com');

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });

    test('Props list should contain all fields in the correct order', () {
      // Arrange
      const entity = CustomerDetailsEntity(
        email: 'test@test.com',
        phone: '123',
        name: 'Name',
        address: 'Cairo',
        bussinessName: 'Biz',
        individualName: 'Indiv',
        taxExempt: 'none',
      );

      // Assert
       expect(entity.props, [
        'test@test.com',
        '123',
        'Name',
        'Cairo',
        'Biz',
        'Indiv',
        'none',
      ]);
    });
  });
}