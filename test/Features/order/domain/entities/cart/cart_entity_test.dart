import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';

void main() {
  group('CartEntity', () {
    test('finalPrice should add totalPrice and deliveryFee', () {
      final cart = CartEntity(totalPrice: 100, deliveryFee: 15);
      expect(cart.finalPrice, 115);

      final cart2 = CartEntity(totalPrice: null, deliveryFee: 10);
      expect(cart2.finalPrice, 10);
    });

    test('copyWith should create a new instance with updated values', () {
      final original = CartEntity(
        id: '1',
        user: 'user1',
        totalPrice: 100,
        deliveryFee: 10,
        cartItems: [CartItemEntity(id: 'item1', price: 50, quantity: 2)],
        appliedCoupons: ['DISCOUNT10'],
      );

      final copy = original.copyWith(
        'user2',
        [CartItemEntity(id: 'item2', price: 30, quantity: 1)],
        '2',
        ['DISCOUNT20'],
        200,
        20,
      );

      expect(copy.id, '2');
      expect(copy.user, 'user2');
      expect(copy.totalPrice, 200);
      expect(copy.deliveryFee, 20);
      expect(copy.cartItems!.first.id, 'item2');
      expect(copy.appliedCoupons!.first, 'DISCOUNT20');
    });

    test('Equatable props should consider all fields', () {
      final cart1 = CartEntity(id: '1', totalPrice: 100);
      final cart2 = CartEntity(id: '1', totalPrice: 100);

      expect(cart1, cart2); // equality via Equatable
    });
  });
}
