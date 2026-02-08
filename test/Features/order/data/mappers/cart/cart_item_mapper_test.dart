import 'package:flowers_app/Features/commerce/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/data/mappers/cart/cart_item_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Implement tests for cart_item_mapper.dart', () {
      // Arrange
      final cartItem = CartItem(
       id: "1",
        quantity: 1,
        price: 100,
        product: Products()
      );

      // Act
      final entity = cartItem.toEntity();

      // Assert
      expect(entity, isA<CartItemEntity>());
      expect(entity.id, '1');
      expect(entity.price, 100);
      expect(entity.quantity, 1);
      expect(entity.product, isA<ProductEntity>());
    });
}
