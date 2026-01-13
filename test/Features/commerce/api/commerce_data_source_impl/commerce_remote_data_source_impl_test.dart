import 'package:flowers_app/Features/commerce/api/api_client/commerce_api.dart';
import 'package:flowers_app/Features/commerce/api/commerce_data_source_impl/commerce_remote_data_source_impl.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'commerce_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CommerceApi])
void main() {
  late CommerceRemoteDataSourceImpl dataSource;
  late MockCommerceApi mockApi;

  setUp(() {
    mockApi = MockCommerceApi();
    dataSource = CommerceRemoteDataSourceImpl(mockApi);
  });

  group('CommerceRemoteDataSourceImpl Tests', () {
    test('getHomeSections should call API and return HomeResponse', () async {
      // Arrange
      final homeResponse = HomeResponse(
        message: 'Success',
        categories: [],
        occasions: [],
        bestSeller: [],
      );
      when(mockApi.getHomeSections()).thenAnswer((_) async => homeResponse);

      // Act
      final result = await dataSource.getHomeSections();

      // Assert
      expect(result, homeResponse);
      verify(mockApi.getHomeSections()).called(1);
    });

    test(
      'getProducts should call API with parameters and return ProductsResponse',
      () async {
        // Arrange
        final productsResponse = ProductsResponse(
          message: 'Success',
          products: [],
          metadata: Metadata(
            currentPage: 1,
            totalPages: 1,
            limit: 20,
            totalItems: 0,
          ),
        );
        when(
          mockApi.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
            search: anyNamed('search'),
            page: anyNamed('page'),
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => productsResponse);

        // Act
        final result = await dataSource.getProducts(
          categoryId: '123',
          occasionId: '456',
          sort: 'price',
          search: 'roses',
          page: 1,
          limit: 20,
        );

        // Assert
        expect(result, productsResponse);
        verify(
          mockApi.getProducts(
            categoryId: '123',
            occasionId: '456',
            sort: 'price',
            search: 'roses',
            page: 1,
            limit: 20,
          ),
        ).called(1);
      },
    );
  });
}
