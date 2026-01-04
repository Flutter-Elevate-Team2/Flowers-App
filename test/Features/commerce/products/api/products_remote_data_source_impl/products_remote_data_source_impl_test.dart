import 'package:flowers_app/Features/commerce/products/api/api_client/products_api.dart';
import 'package:flowers_app/Features/commerce/products/api/products_remote_data_source_impl/products_remote_data_source_impl.dart';
import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductsApi])
void main() {
  late ProductsRemoteDataSourceImpl dataSource;
  late MockProductsApi mockProductsApi;

  _setup(() {
    mockProductsApi = MockProductsApi();
    dataSource = ProductsRemoteDataSourceImpl(mockProductsApi);
  });

  _getProductsSuccessTest(() => mockProductsApi, () => dataSource);
  _exceptionPropagationTest(() => mockProductsApi, () => dataSource);
}

void _setup(void Function() init) {
  setUp(() {
    init();
  });
}

void _getProductsSuccessTest(
    MockProductsApi Function() api,
    ProductsRemoteDataSourceImpl Function() dataSource,
    ) {
  test('should call ProductsApi.getProducts and return ProductsResponse', () async {
    final productsResponse = ProductsResponse(
      products: [],
      metadata: Metadata(),
    );

    when(api().getProducts(
      categoryId: anyNamed('categoryId'),
      occasionId: anyNamed('occasionId'),
      sort: anyNamed('sort'),
      search: anyNamed('search'),
      page: anyNamed('page'),
      limit: anyNamed('limit'),
    )).thenAnswer((_) async => productsResponse);

    final result = await dataSource().getProducts(
      categoryId: '1',
      occasionId: '2',
      sort: 'price',
      search: 'flower',
      page: 1,
      limit: 10,
    );

    expect(result, productsResponse);
    verify(api().getProducts(
      categoryId: '1',
      occasionId: '2',
      sort: 'price',
      search: 'flower',
      page: 1,
      limit: 10,
    )).called(1);
  });
}

void _exceptionPropagationTest(
    MockProductsApi Function() api,
    ProductsRemoteDataSourceImpl Function() dataSource,
    ) {
  test('should propagate exceptions from ProductsApi', () async {
    when(api().getProducts(
      categoryId: anyNamed('categoryId'),
      occasionId: anyNamed('occasionId'),
      sort: anyNamed('sort'),
      search: anyNamed('search'),
      page: anyNamed('page'),
      limit: anyNamed('limit'),
    )).thenThrow(Exception('API Error'));

    final call = dataSource().getProducts;

    expect(
          () => call(
        categoryId: '1',
        occasionId: '2',
        sort: 'price',
        search: 'flower',
        page: 1,
        limit: 10,
      ),
      throwsException,
    );
  });
}
