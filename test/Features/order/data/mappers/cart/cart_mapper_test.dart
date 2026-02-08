import 'package:flowers_app/Features/order/data/mappers/cart/cart_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Implement tests for cart_mapper.dart', () {

      // Arrange
      final cart = Cart(
        id: '1',
      cartItems: [],
        totalPrice: 100,
        V: 1,
        user: "user",
        updatedAt: "",
        createdAt: "",
        appliedCoupons: []
      );

      // Act
      final entity = cart.toEntity();

      // Assert
      expect(entity, isA<CartEntity>());
      expect(entity.id, "1");
      expect(entity.totalPrice, 100);
      expect(entity.user, "user");
      expect(entity.cartItems, []);
      expect(entity.appliedCoupons, []);
    });
}
