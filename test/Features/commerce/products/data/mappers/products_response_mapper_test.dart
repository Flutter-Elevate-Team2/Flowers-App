import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/commerce/products/data/mappers/products_response_mapper.dart';
import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/commerce/products/domain/entities/paginated_products_entity.dart';

void main() {
  _productsResponseMapperTests();
}

void _productsResponseMapperTests() {
  group('ProductsResponseMapper Tests', () {
    test(
      'should map ProductsResponse to PaginatedProductsEntity when products and metadata are not null',
          () {
        final response = ProductsResponse(
          products: [
            Products(
              id: '1',
              title: 'Rose',
              slug: 'rose',
              description: 'flower',
              imgCover: 'img',
              images: ['img1'],
              price: 100,
              priceAfterDiscount: 80,
              quantity: 10,
              category: '123',
              occasion: '456',
              sold: 5,
              rateAvg: 4,
              rateCount: 10,
              isInWishlist: true,
              discount: 20,
            ),
          ],
          metadata: Metadata(
            currentPage: 2,
            totalPages: 5,
            limit: 10,
            totalItems: 50,
            nextPage: 1,
            prevPage: 0,
          ),
        );

        final PaginatedProductsEntity entity = response.toPaginatedEntity();

        expect(entity.products.length, 1);
        expect(entity.products.first.title, 'Rose');
        expect(entity.products.first.price, 100);

        expect(entity.meta.currentPage, 2);
        expect(entity.meta.totalPages, 5);
        expect(entity.meta.limit, 10);
        expect(entity.meta.totalItems, 50);
      },
    );

    test(
      'should return empty products list and default metadata when products and metadata are null',
          () {
        final response = ProductsResponse();

        final PaginatedProductsEntity entity = response.toPaginatedEntity();

        expect(entity.products, isEmpty);
        expect(entity.meta.currentPage, 1);
        expect(entity.meta.totalPages, 1);
        expect(entity.meta.limit, 40);
        expect(entity.meta.totalItems, 0);
      },
    );

    test('should map empty products list correctly', () {
      final response = ProductsResponse(
        products: [],
        metadata: Metadata(
          currentPage: 1,
          totalPages: 1,
          limit: 20,
          totalItems: 0,
          prevPage: 0,
          nextPage: 0,
        ),
      );

      final PaginatedProductsEntity entity = response.toPaginatedEntity();

      expect(entity.products, isEmpty);
      expect(entity.meta.currentPage, 1);
    });
  });
}
