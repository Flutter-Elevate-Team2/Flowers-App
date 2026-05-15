import 'package:flowers_app/Features/order/data/mappers/cart/cart_response_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Implement tests for cart_response_mapper.dart', () {
    // Arrange
    final cartResponse = CartResponseModel(
     message: "success",
      cart: Cart(),
      numOfCartItems: 2
    );

    // Act
    final entity = cartResponse.toEntity();

    // Assert
    expect(entity, isA<CartResponseEntity>());
    expect(entity.message, 'success');
    expect(entity.cart, isA<CartEntity>());
    expect(entity.numOfCartItems, 2);
  });
  test('toEntity should handle null CartResponse', () {
    // Arrange
    final cartResponse = CartResponseModel(
        message: "",
        cart: null,
        numOfCartItems: 0
    );

    // Act
    final entity = cartResponse.toEntity();

    // Assert
    expect(entity, isA<CartResponseEntity>());
    expect(entity.message, "");
    expect(entity.cart, null);
    expect(entity.numOfCartItems, 0);

  });
}