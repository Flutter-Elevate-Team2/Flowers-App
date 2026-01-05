import 'package:flowers_app/Features/commerce/data/commerce_data_source_contract/commerce_remote_data_source_contract.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/best_seller.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/category.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/occasion.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/commerce/data/repos/commerce_repo_impl.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/paginated_products_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'commerce_repo_impl_test.mocks.dart';

@GenerateMocks([CommerceRemoteDataSourceContract])
void main() {
  late CommerceRepoImpl repo;
  late MockCommerceRemoteDataSourceContract mockDataSource;

  setUp(() {
    mockDataSource = MockCommerceRemoteDataSourceContract();
    repo = CommerceRepoImpl(mockDataSource);
  });

  group('CommerceRepoImpl Tests', () {
    group('getHomeSections', () {
      test('should return SuccessResponse when data source succeeds', () async {
        // Arrange
        final homeResponse = HomeResponse(
          message: 'Success',
          categories: [Category(id: '1', name: 'Roses', image: 'roses.png')],
          occasions: [
            Occasion(id: '1', name: 'Birthday', image: 'birthday.png'),
          ],
          bestSeller: [
            BestSeller(
              id: '1',
              title: 'Rose Bouquet',
              slug: 'rose-bouquet',
              description: 'Beautiful roses',
              imgCover: 'roses.png',
              images: ['img1.png'],
              price: 100,
              priceAfterDiscount: 80,
              quantity: 10,
              category: '123',
              occasion: '456',
              sold: 5,
              rateAvg: 4,
              rateCount: 10,
              discount: 20,
            ),
          ],
        );
        when(
          mockDataSource.getHomeSections(),
        ).thenAnswer((_) async => homeResponse);

        // Act
        final result = await repo.getHomeSections();

        // Assert
        expect(result, isA<SuccessResponse<HomeEntity>>());
        final success = result as SuccessResponse<HomeEntity>;
        expect(success.data.categories.length, 1);
        expect(success.data.occasions.length, 1);
        expect(success.data.bestSellers.length, 1);
        verify(mockDataSource.getHomeSections()).called(1);
      });

      test(
        'should return ErrorResponse when data source throws exception',
        () async {
          // Arrange
          when(
            mockDataSource.getHomeSections(),
          ).thenThrow(Exception('Failed to fetch'));

          // Act
          final result = await repo.getHomeSections();

          // Assert
          expect(result, isA<ErrorResponse<HomeEntity>>());
          verify(mockDataSource.getHomeSections()).called(1);
        },
      );
    });

    group('getProducts', () {
      test('should return SuccessResponse when data source succeeds', () async {
        // Arrange
        final productsResponse = ProductsResponse(
          message: 'Success',
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
            currentPage: 1,
            totalPages: 1,
            limit: 20,
            totalItems: 1,
            nextPage: null,
            prevPage: null,
          ),
        );
        when(
          mockDataSource.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
            search: anyNamed('search'),
            page: anyNamed('page'),
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => productsResponse);

        // Act
        final result = await repo.getProducts(
          categoryId: '123',
          occasionId: '456',
          sort: 'price',
          search: 'roses',
          page: 1,
          limit: 20,
        );

        // Assert
        expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());
        final success = result as SuccessResponse<PaginatedProductsEntity>;
        expect(success.data.products.length, 1);
        expect(success.data.meta.currentPage, 1);
        verify(
          mockDataSource.getProducts(
            categoryId: '123',
            occasionId: '456',
            sort: 'price',
            search: 'roses',
            page: 1,
            limit: 20,
          ),
        ).called(1);
      });

      test(
        'should return ErrorResponse when data source throws exception',
        () async {
          // Arrange
          when(
            mockDataSource.getProducts(
              categoryId: anyNamed('categoryId'),
              occasionId: anyNamed('occasionId'),
              sort: anyNamed('sort'),
              search: anyNamed('search'),
              page: anyNamed('page'),
              limit: anyNamed('limit'),
            ),
          ).thenThrow(Exception('Failed to fetch products'));

          // Act
          final result = await repo.getProducts();

          // Assert
          expect(result, isA<ErrorResponse<PaginatedProductsEntity>>());
          verify(
            mockDataSource.getProducts(
              categoryId: anyNamed('categoryId'),
              occasionId: anyNamed('occasionId'),
              sort: anyNamed('sort'),
              search: anyNamed('search'),
              page: anyNamed('page'),
              limit: anyNamed('limit'),
            ),
          ).called(1);
        },
      );
    });
  });
}
