import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/domain/products_repo_contract/products_repo_contract.dart';
import 'package:flowers_app/Features/products/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductsRepoContract])
void main() {
  late ProductsUseCase productsUseCase;
  late MockProductsRepoContract mockProductsRepo;

  setUp(() {
    final dummyPaginated = PaginatedProductsEntity(
      products: const [],
      meta: MetaDataEntity(
        currentPage: 1,
        totalPages: 1,
        totalItems: 0,
        limit: 10,
        prevPage: 0,
        nextPage: 0,
      ),
    );

    provideDummy<BaseResponse<PaginatedProductsEntity>>(
      SuccessResponse(data: dummyPaginated),
    );

    mockProductsRepo = MockProductsRepoContract();
    productsUseCase = ProductsUseCase(mockProductsRepo);
  });

  test(
    'when call getProducts usecase it should call repo with correct params',
    () async {
      // Arrange
      const categoryId = '123456789';
      const occasionId = '1234567891';
      const sort = 'price';
      const page = 1;
      const limit = 10;

      final productsList = [
        ProductEntity(
          id: '1',
          title: 'Flower',
          slug: 'rose',
          description: 'flower',
          imgCover: 'img',
          images: [],
          price: 100,
          priceAfterDiscount: 80,
          quantity: 10,
          categoryId: categoryId,
          occasionId: occasionId,
          sold: 5,
          rateAvg: 4,
          rateCount: 10,
          isInWishlist: false,
          discount: 20,
        ),
      ];

      final meta = MetaDataEntity(
        currentPage: 1,
        totalPages: 1,
        totalItems: productsList.length,
        limit: 10,
        prevPage: 0,
        nextPage: 0,
      );

      final paginatedProducts = PaginatedProductsEntity(
        products: productsList,
        meta: meta,
      );

      when(
        mockProductsRepo.getProducts(
          categoryId: categoryId,
          occasionId: occasionId,
          sort: sort,
          page: page,
          limit: limit,
        ),
      ).thenAnswer((_) async => SuccessResponse(data: paginatedProducts));

      // Act
      final result = await productsUseCase.getProducts(
        categoryId: categoryId,
        occasionId: occasionId,
        sort: sort,
        page: page,
        limit: limit,
      );

      expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());

      final success = result as SuccessResponse<PaginatedProductsEntity>;

      expect(success.data.products.length, 1);
      expect(success.data.products.first.title, 'Flower');

      verify(
        mockProductsRepo.getProducts(
          categoryId: categoryId,
          occasionId: occasionId,
          sort: sort,
          page: page,
          limit: limit,
        ),
      ).called(1);
    },
  );

  test('should return ErrorResponse when repo returns error', () async {
    // Arrange
    final errorResponse = ErrorResponse<PaginatedProductsEntity>(
      errorMessage: 'Something went wrong',
    );

    when(mockProductsRepo.getProducts()).thenAnswer((_) async => errorResponse);

    // Act
    final result = await productsUseCase.getProducts();

    // Assert
    expect(result, isA<ErrorResponse<PaginatedProductsEntity>>());
  });

  test('should pass search param correctly', () async {
    const search = 'rose';

    when(mockProductsRepo.getProducts(search: search)).thenAnswer(
      (_) async => SuccessResponse(
        data: PaginatedProductsEntity(
          products: [],
          meta: MetaDataEntity(
            currentPage: 1,
            totalPages: 1,
            totalItems: 0,
            limit: 10,
            prevPage: 0,
            nextPage: 0,
          ),
        ),
      ),
    );

    await productsUseCase.getProducts(search: search);

    verify(mockProductsRepo.getProducts(search: search)).called(1);
  });

  test('should request second page correctly', () async {
    const page = 2;

    when(mockProductsRepo.getProducts(page: page)).thenAnswer(
      (_) async => SuccessResponse(
        data: PaginatedProductsEntity(
          products: [],
          meta: MetaDataEntity(
            currentPage: page,
            totalPages: 3,
            totalItems: 30,
            limit: 10,
            nextPage: 3,
            prevPage: 1,
          ),
        ),
      ),
    );

    final result = await productsUseCase.getProducts(page: page);

    final success = result as SuccessResponse<PaginatedProductsEntity>;
    expect(success.data.meta.currentPage, page);
  });

  test('should return empty products list safely', () async {
    when(mockProductsRepo.getProducts()).thenAnswer(
      (_) async => SuccessResponse(
        data: PaginatedProductsEntity(
          products: [],
          meta: MetaDataEntity(
            currentPage: 1,
            totalPages: 0,
            totalItems: 0,
            limit: 10,
            prevPage: 0,
            nextPage: 0,
          ),
        ),
      ),
    );

    final result = await productsUseCase.getProducts();

    final success = result as SuccessResponse<PaginatedProductsEntity>;
    expect(success.data.products, isEmpty);
  });
}
