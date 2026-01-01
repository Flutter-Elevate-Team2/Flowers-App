import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_view_model_test.mocks.dart';

@GenerateMocks([ProductsUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  provideDummy<BaseResponse<PaginatedProductsEntity>>(
    SuccessResponse(
      data: PaginatedProductsEntity(
        products: [],
        meta: MetaDataEntity(
          currentPage: 1,
          totalPages: 1,
          prevPage: null,
          nextPage: null,
          limit: 8,
          totalItems: 0,
        ),
      ),
    ),
  );

  _setup();
  _fetchSuccessTest();
  _fetchErrorTest();
  _paginationTest();
  _searchTest();
  _searchFocusTest();
}

late ProductsViewModel viewModel;
late MockProductsUseCase mockUseCase;

final tProduct1 = ProductEntity(
  id: '1',
  title: 'Rose',
  price: 10,
  slug: '',
  description: '',
  imgCover: '',
  images: const [],
  priceAfterDiscount: 0,
  quantity: 0,
  categoryId: '',
  occasionId: '',
  sold: 0,
  rateAvg: 0,
  rateCount: 0,
  isInWishlist: false,
  discount: 0,
);

final tProduct2 = ProductEntity(
  id: '2',
  title: 'Tulip',
  price: 15,
  slug: '',
  description: '',
  imgCover: '',
  images: const [],
  priceAfterDiscount: 0,
  quantity: 0,
  categoryId: '',
  occasionId: '',
  sold: 0,
  rateAvg: 0,
  rateCount: 0,
  isInWishlist: false,
  discount: 0,
);

final tPage1 = PaginatedProductsEntity(
  products: [tProduct1],
  meta: MetaDataEntity(
    currentPage: 1,
    totalPages: 2,
    prevPage: null,
    nextPage: 2,
    limit: 8,
    totalItems: 2,
  ),
);

final tPage2 = PaginatedProductsEntity(
  products: [tProduct2],
  meta: MetaDataEntity(
    currentPage: 2,
    totalPages: 2,
    prevPage: 1,
    nextPage: null,
    limit: 8,
    totalItems: 2,
  ),
);

void _setup() {
  setUp(() {
    mockUseCase = MockProductsUseCase();
    viewModel = ProductsViewModel(mockUseCase);
  });

  tearDown(() async {
    await viewModel.close();
  });
}

void _fetchSuccessTest() {
  group('Fetch Success', () {
    test('emits [Loading, Success] when fetch products succeeds', () async {
      when(
        mockUseCase.getProducts(
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
          search: anyNamed('search'),
          page: anyNamed('page'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tPage1));

      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'loading',
            true,
          ),
          isA<ProductsStates>()
              .having((s) => s.productsState?.isLoading, 'loading', false)
              .having(
                (s) => s.productsState?.data!.first.title,
                'title',
                'Rose',
              ),
        ]),
      );

      viewModel.doIntent(FetchProductsEvent());
    });
  });
}

void _fetchErrorTest() {
  group('Fetch Error', () {
    test('emits [Loading, Error] when fetch products fails', () async {
      when(
        mockUseCase.getProducts(
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
          search: anyNamed('search'),
          page: anyNamed('page'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer(
        (_) async => ErrorResponse(errorMessage: 'Failed to load products'),
      );

      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'loading',
            true,
          ),
          isA<ProductsStates>().having(
            (s) => s.productsState?.errorMessage,
            'error',
            'Failed to load products',
          ),
        ]),
      );

      viewModel.doIntent(FetchProductsEvent());
    });
  });
}

void _paginationTest() {
  group('Pagination', () {
    test('goToNextPage fetches next page correctly', () async {
      when(
        mockUseCase.getProducts(
          page: 1,
          limit: anyNamed('limit'),
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
          search: anyNamed('search'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tPage1));

      when(
        mockUseCase.getProducts(
          page: 2,
          limit: anyNamed('limit'),
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
          search: anyNamed('search'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tPage2));

      viewModel.doIntent(FetchProductsEvent());
      await Future.delayed(Duration.zero);

      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'loading',
            true,
          ),
          isA<ProductsStates>().having(
            (s) => s.productsState?.data!.first.title,
            'title',
            'Tulip',
          ),
        ]),
      );

      viewModel.goToNextPage();
    });
  });
}

void _searchTest() {
  group('Search', () {
    test('onSearchSubmitted emits loading then results', () async {
      when(
        mockUseCase.getProducts(
          search: 'rose',
          page: anyNamed('page'),
          limit: anyNamed('limit'),
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tPage1));

      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProductsStates>()
              .having((s) => s.searchText, 'search', 'rose')
              .having((s) => s.productsState?.isLoading, 'loading', true),
          emitsThrough(
            isA<ProductsStates>().having(
              (s) => s.productsState?.isLoading,
              'loading',
              true,
            ),
          ),
          isA<ProductsStates>()
              .having((s) => s.productsState?.isLoading, 'loading', false)
              .having(
                (s) => s.productsState?.data!.first.title,
                'title',
                'Rose',
              ),
        ]),
      );

      viewModel.onSearchSubmitted('rose');
    });
  });
}

void _searchFocusTest() {
  group('Search Focus', () {
    test('onSearchFocusChanged emits correct focus state', () async {
      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProductsStates>().having(
            (s) => s.isSearchFocused,
            'focused',
            true,
          ),
          isA<ProductsStates>().having(
            (s) => s.isSearchFocused,
            'focused',
            false,
          ),
        ]),
      );

      viewModel.onSearchFocusChanged(true);
      viewModel.onSearchFocusChanged(false);
    });
  });
}
