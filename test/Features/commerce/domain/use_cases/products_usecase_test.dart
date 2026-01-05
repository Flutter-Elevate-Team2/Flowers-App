import 'package:flowers_app/Features/commerce/domain/entities/product_entities/meta_data_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/domain/repos/commerce_repo_contract.dart';
import 'package:flowers_app/Features/commerce/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_usecase_test.mocks.dart';

@GenerateMocks([CommerceRepoContract])
void main() {
  late ProductsUseCase productsUseCase;
  late MockCommerceRepoContract mockProductsRepo;

  _setup(() {
    mockProductsRepo = MockCommerceRepoContract();
    productsUseCase = ProductsUseCase(mockProductsRepo);
  });

  _getProductsSuccessTest(() => mockProductsRepo, () => productsUseCase);
}

void _setup(void Function() init) {
  setUp(() {
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

    init();
  });
}

void _getProductsSuccessTest(
  MockCommerceRepoContract Function() repo,
  ProductsUseCase Function() useCase,
) {
  test(
    'should return SuccessResponse with PaginatedProductsEntity when repo succeeds',
    () async {
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
          prevPage: 0,
        ),
      );

      when(
        repo().getProducts(
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
          search: anyNamed('search'),
          page: anyNamed('page'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: paginatedProducts));

      final result = await useCase().getProducts();

      expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());
      final success = result as SuccessResponse<PaginatedProductsEntity>;
      expect(success.data.products.length, 1);
      expect(success.data.products.first.title, 'Rose');

      verify(
        repo().getProducts(
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
