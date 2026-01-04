import 'package:dio/dio.dart';
import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/commerce/products/data/products_repo_impl/products_repo_impl.dart';
import 'package:flowers_app/Features/commerce/products/data/products_data_source_contract/products_data_source_contract.dart';
import 'package:flowers_app/Features/commerce/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/commerce/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_repo_impl_test.mocks.dart';

@GenerateMocks([ProductsRemoteDataSourceContract])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductsRepoImpl productsRepo;
  late MockProductsRemoteDataSourceContract mockRemoteDataSource;

  _setup(() {
    mockRemoteDataSource = MockProductsRemoteDataSourceContract();
    productsRepo = ProductsRepoImpl(mockRemoteDataSource);
  });

  _getProductsSuccessTest(() => mockRemoteDataSource, () => productsRepo);
  _successMappedEntityTest(() => mockRemoteDataSource, () => productsRepo);
  _dioExceptionTest(() => mockRemoteDataSource, () => productsRepo);
  _genericExceptionTest(() => mockRemoteDataSource, () => productsRepo);
}

void _setup(void Function() init) {
  setUp(() {
    final dummyPaginated = PaginatedProductsEntity(
      products: const [],
      meta: MetaDataEntity(
        currentPage: 1,
        totalPages: 1,
        limit: 20,
        totalItems: 0,
        nextPage: 0,
        prevPage: 0,
      ),
    );

    provideDummy<BaseResponse<PaginatedProductsEntity>>(
      SuccessResponse(data: dummyPaginated),
    );

    init();
  });
}

void _getProductsSuccessTest(
    MockProductsRemoteDataSourceContract Function() remote,
    ProductsRepoImpl Function() repo,
    ) {
  test('should return SuccessResponse<PaginatedProductsEntity> when remote succeeds', () async {
    const categoryId = 'cat123';
    const occasionId = 'occ456';

    final productsResponse = ProductsResponse(
      products: [
        Products(
          id: '1',
          title: 'Rose',
          slug: 'rose',
          description: 'Nice flower',
          imgCover: 'img',
          images: ['img1'],
          price: 100,
          priceAfterDiscount: 80,
          quantity: 10,
          category: categoryId,
          occasion: occasionId,
          sold: 5,
          rateAvg: 4,
          rateCount: 10,
          isInWishlist: false,
          discount: 20,
        ),
      ],
    );

    when(remote().getProducts(categoryId: categoryId, occasionId: occasionId, sort: null))
        .thenAnswer((_) async => productsResponse);

    final result = await repo().getProducts(categoryId: categoryId, occasionId: occasionId);

    expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());
    final success = result as SuccessResponse<PaginatedProductsEntity>;
    expect(success.data.products.length, 1);
    expect(success.data.products.first.title, 'Rose');

    verify(remote().getProducts(categoryId: categoryId, occasionId: occasionId, sort: null)).called(1);
  });
}

void _successMappedEntityTest(
    MockProductsRemoteDataSourceContract Function() remote,
    ProductsRepoImpl Function() repo,
    ) {
  test('repo should return SuccessResponse with mapped entity', () async {
    final productsResponse = ProductsResponse(
      products: [
        Products(
          id: '1',
          title: 'Rose',
          slug: 'rose',
          description: 'Nice flower',
          imgCover: 'img',
          images: ['img1'],
          price: 100,
          priceAfterDiscount: 80,
          quantity: 10,
          category: 'cat123',
          occasion: 'occ456',
          sold: 5,
          rateAvg: 4,
          rateCount: 10,
          isInWishlist: false,
          discount: 20,
        ),
      ],
    );

    when(remote().getProducts()).thenAnswer((_) async => productsResponse);

    final result = await repo().getProducts();

    expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());
    final success = result as SuccessResponse<PaginatedProductsEntity>;
    expect(success.data.products, isNotEmpty);
  });
}

void _dioExceptionTest(
    MockProductsRemoteDataSourceContract Function() remote,
    ProductsRepoImpl Function() repo,
    ) {
  test('should return ErrorResponse with backend message when DioException occurs', () async {
    final dioError = DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {'message': 'Something went wrong'},
      ),
      type: DioExceptionType.badResponse,
    );

    when(remote().getProducts(categoryId: anyNamed('categoryId'), occasionId: anyNamed('occasionId'), sort: anyNamed('sort')))
        .thenThrow(dioError);

    final result = await repo().getProducts();

    expect(result, isA<ErrorResponse<PaginatedProductsEntity>>());
    expect((result as ErrorResponse).errorMessage, 'Something went wrong');
  });
}

void _genericExceptionTest(
    MockProductsRemoteDataSourceContract Function() remote,
    ProductsRepoImpl Function() repo,
    ) {
  test('should return ErrorResponse with unknownError when generic Exception occurs', () async {
    when(remote().getProducts(categoryId: anyNamed('categoryId'), occasionId: anyNamed('occasionId'), sort: anyNamed('sort')))
        .thenThrow(Exception('Unexpected error'));

    final result = await repo().getProducts();

    expect(result, isA<ErrorResponse<PaginatedProductsEntity>>());
    expect((result as ErrorResponse).errorMessage, ErrorStrings.unknownError);
  });
}
