import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';

void main() {
  group('CartItemEntity', () {
    ProductEntity createProduct({String id = 'p1'}) {
      return ProductEntity(
        id: id,
        title: 'Product $id',
        slug: 'product-$id',
        description: 'Description for $id',
        imgCover: 'https://example.com/$id.jpg',
        images: ['https://example.com/$id-1.jpg', 'https://example.com/$id-2.jpg'],
        price: 100,
        priceAfterDiscount: 80,
        quantity: 10,
        categoryId: 'cat1',
        occasionId: 'occ1',
        sold: 5,
        rateAvg: 4,
        rateCount: 10,
        isInWishlist: false,
        discount: 20,
      );
    }

    test('copyWith should create a new instance with updated values', () {
      final product1 = createProduct(id: 'p1');
      final product2 = createProduct(id: 'p2');

      final original = CartItemEntity(
        id: 'c1',
        price: 100,
        quantity: 2,
        product: product1,
      );

      final copy = original.copyWith(
        product2,
        200,
        5,
        'c2',
      );

      expect(copy.id, 'c2');
      expect(copy.price, 200);
      expect(copy.quantity, 5);
      expect(copy.product, product2);
    });

    test('Equatable props should consider all fields', () {
      final product = createProduct(id: 'p1');

      final item1 = CartItemEntity(
        id: 'c1',
        price: 100,
        quantity: 2,
        product: product,
      );
      final item2 = CartItemEntity(
        id: 'c1',
        price: 100,
        quantity: 2,
        product: product,
      );

      expect(item1, item2); // equality via Equatable
    });
  });
}
