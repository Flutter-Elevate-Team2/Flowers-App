import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/data/mappers/product_mapper.dart';

void main() {
  group('ProductsMapper Tests', () {
    test(
      'should map Products DTO to ProductsEntity correctly when all fields are present',
      () {
        // Arrange
        final productDto = Products(
          id: '1',
          title: 'Rose',
          slug: 'rose',
          description: 'flower',
          imgCover: 'img.png',
          images: ['img1.png', 'img2.png'],
          price: 100,
          priceAfterDiscount: 80,
          quantity: 10,
          category: '123',
          occasion: '456',
          sold: 5,
          rateAvg: 4,
          rateCount: 20,
          isInWishlist: true,
          discount: 50,
        );

        // Act
        final ProductEntity entity = productDto.toEntity();

        // Assert
        expect(entity.id, '1');
        expect(entity.title, 'Rose');
        expect(entity.slug, 'rose');
        expect(entity.description, 'flower');
        expect(entity.imgCover, 'img.png');
        expect(entity.images.length, 2);
        expect(entity.price, 100);
        expect(entity.priceAfterDiscount, 80);
        expect(entity.quantity, 10);
        expect(entity.categoryId, '123');
        expect(entity.occasionId, '456');
        expect(entity.sold, 5);
        expect(entity.rateAvg, 4);
        expect(entity.rateCount, 20);
        expect(entity.isInWishlist, true);
        expect(entity.discount, 50);
      },
    );

    test('should return default values when Products DTO has null fields', () {
      // Arrange
      final productDto = Products();

      // Act
      final ProductEntity entity = productDto.toEntity();

      // Assert
      expect(entity.id, '');
      expect(entity.title, '');
      expect(entity.slug, '');
      expect(entity.description, '');
      expect(entity.imgCover, '');
      expect(entity.images, isEmpty);
      expect(entity.price, 0);
      expect(entity.priceAfterDiscount, 0);
      expect(entity.quantity, 0);
      expect(entity.categoryId, '');
      expect(entity.occasionId, '');
      expect(entity.sold, 0);
      expect(entity.rateAvg, 0);
      expect(entity.rateCount, 0);
      expect(entity.isInWishlist, false);
      expect(entity.discount, 0);
    });
  });
}
