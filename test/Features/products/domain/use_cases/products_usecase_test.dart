import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/products/domain/products_repo_contract/products_repo_contract.dart';
import 'package:flowers_app/Features/products/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

import 'products_usecase_test.mocks.dart';

@GenerateMocks([ProductsRepoContract])
void main() {
  late ProductsUseCase productsUseCase;
  late MockProductsRepoContract mockProductsRepo;

  setUp(() {
    mockProductsRepo = MockProductsRepoContract();
    productsUseCase = ProductsUseCase(mockProductsRepo);

    final dummyPaginated = PaginatedProductsEntity(
      products: const [],
      meta: MetaDataEntity(
        currentPage: 1,
        totalPages: 1,
        totalItems: 0,
        limit: 20,
        prevPage: 0,
        nextPage: 2,
      ),
    );

    provideDummy<BaseResponse<PaginatedProductsEntity>>(
      SuccessResponse(data: dummyPaginated),
    );
  });

  test(
    'should return SuccessResponse with PaginatedProductsEntity when repo succeeds',
    () async {
      // Arrange
      final paginatedProducts = PaginatedProductsEntity(
        products: [
          ProductEntity(
            id: '1',
            title: 'Rose',
            slug: 'rose',
            description: 'flower',
            imgCover: 'img',
            images: const [],
            price: 100,
            priceAfterDiscount: 80,
            quantity: 10,
            categoryId: '123',
            occasionId: '456',
            sold: 5,
            rateAvg: 4,
            rateCount: 10,
            isInWishlist: false,
            discount: 20,
          ),
        ],
        meta: MetaDataEntity(
          currentPage: 1,
          totalPages: 1,
          totalItems: 1,
          limit: 20,
          nextPage: 2,
          prevPage: 0
        ),
      );

      when(
        mockProductsRepo.getProducts(
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
          search: anyNamed('search'),
          page: anyNamed('page'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: paginatedProducts));

      // Act
      final result = await productsUseCase.getProducts();

      // Assert
      expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());
      final success = result as SuccessResponse<PaginatedProductsEntity>;
      expect(success.data.products.length, 1);
      expect(success.data.products.first.title, 'Rose');

      verify(
        mockProductsRepo.getProducts(
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
}
