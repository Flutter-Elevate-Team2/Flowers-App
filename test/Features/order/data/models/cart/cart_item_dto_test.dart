 import 'package:flowers_app/Features/commerce/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartItem Model Tests', () {
     final tProductJson = {
      'title': 'Red Rose',
      'price': 100,
      'id': 'p1',
    };

    final tCartItemJson = {
      'product': tProductJson,
      'price': 100,
      'quantity': 2,
      '_id': 'c1',
    };

    test('fromJson should create a valid CartItem object from JSON', () {
      // Act
      final result = CartItem.fromJson(tCartItemJson);

      // Assert
      expect(result.id, 'c1');
      expect(result.price, 100);
      expect(result.quantity, 2);
      expect(result.product, isA<Products>());
       expect(result.product?.title, 'Red Rose');
    });

     test('toJson should return a valid Map containing the correct data', () {
       // Arrange
       final tProduct = Products(title: 'Red Rose', price: 100, id: 'p1');
       final cartItem = CartItem(
         id: 'c1',
         price: 100,
         quantity: 5,
         product: tProduct,
       );

       // Act
       final json = cartItem.toJson();

       // Assert
       expect(json['_id'], 'c1');
       expect(json['price'], 100);

        expect(json['product'], isA<Products>());
       expect((json['product'] as Products).title, 'Red Rose');
     });
    test('should handle null values gracefully', () {
      // Act
      final result = CartItem.fromJson({});

      // Assert
      expect(result.id, isNull);
      expect(result.product, isNull);
    });
  });
}