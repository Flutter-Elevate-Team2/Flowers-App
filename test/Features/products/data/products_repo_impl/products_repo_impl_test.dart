import 'package:dio/dio.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/data/products_repo_impl/products_repo_impl.dart';
import 'package:flowers_app/Features/products/data/products_data_source_contract/products_data_source_contract.dart';
import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
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

  setUp(() {
    mockRemoteDataSource = MockProductsRemoteDataSourceContract();
    productsRepo = ProductsRepoImpl(mockRemoteDataSource);

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
  });

  group('Products Repo Tests', () {
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

    test(
      'should return SuccessResponse<PaginatedProductsEntity> when remote succeeds',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.getProducts(
            categoryId: categoryId,
            occasionId: occasionId,
            sort: null,
          ),
        ).thenAnswer((_) async => productsResponse);

        // Act
        final result = await productsRepo.getProducts(
          categoryId: categoryId,
          occasionId: occasionId,
        );

        // Assert
        expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());

        final success = result as SuccessResponse<PaginatedProductsEntity>;
        expect(success.data.products.length, 1);
        expect(success.data.products.first.title, 'Rose');

        verify(
          mockRemoteDataSource.getProducts(
            categoryId: categoryId,
            occasionId: occasionId,
            sort: null,
          ),
        ).called(1);
      },
    );

    test('repo should return SuccessResponse with mapped entity', () async {
      when(
        mockRemoteDataSource.getProducts(),
      ).thenAnswer((_) async => productsResponse);

      final result = await productsRepo.getProducts();

      expect(result, isA<SuccessResponse<PaginatedProductsEntity>>());

      final success = result as SuccessResponse<PaginatedProductsEntity>;

      expect(success.data.products, isNotEmpty);
    });

    test(
      'should return ErrorResponse with backend message when DioException occurs',
      () async {
        // Arrange
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 400,
            data: {'message': 'Something went wrong'},
          ),
          type: DioExceptionType.badResponse,
        );

        when(
          mockRemoteDataSource.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
          ),
        ).thenThrow(dioError);

        // Act
        final result = await productsRepo.getProducts();

        // Assert
        expect(result, isA<ErrorResponse<PaginatedProductsEntity>>());
        expect((result as ErrorResponse).errorMessage, 'Something went wrong');
      },
    );

    test(
      'should return ErrorResponse with unknownError when generic Exception occurs',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
          ),
        ).thenThrow(Exception('Unexpected error'));

        // Act
        final result = await productsRepo.getProducts();

        // Assert
        expect(result, isA<ErrorResponse<PaginatedProductsEntity>>());
        expect(
          (result as ErrorResponse).errorMessage,
          ErrorStrings.unknownError,
        );
      },
    );
  });
}
