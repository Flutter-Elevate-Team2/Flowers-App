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
            'isLoading 1',
            true,
          ),
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'isLoading 2',
            true,
          ),
          isA<ProductsStates>()
              .having((s) => s.productsState?.isLoading, 'isLoading', false)
              .having((s) => s.productsState?.data!.length, 'length', 1)
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
            'isLoading 1',
            true,
          ),
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'isLoading 2',
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
  group('Pagination (Infinite Scroll)', () {
    test('LoadMoreProductsEvent appends new data to existing list', () async {
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

      expectLater(
        viewModel.stream,
        emitsInOrder([
          // 1. Fetch Start (Loading 1)
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'Full Loading 1',
            true,
          ),
          // 2. Fetch Loading 2 (observed double emit)
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'Full Loading 2',
            true,
          ),

          // 3. Fetch Success
          isA<ProductsStates>()
              .having((s) => s.productsState?.isLoading, 'Loaded', false)
              .having((s) => s.productsState?.data!.length, 'Count 1', 1)
              .having((s) => s.nextPage, 'Next Page is 2', 2),

          // 4. Load More Loading
          isA<ProductsStates>()
              .having((s) => s.isPaginationLoading, 'Pagination Loading', true)
              .having((s) => s.productsState?.data!.length, 'Count still 1', 1),

          // 5. Load More Success
          isA<ProductsStates>()
              .having((s) => s.isPaginationLoading, 'Pagination Done', false)
              .having(
                (s) => s.productsState?.data!.length,
                'Count Merged to 2',
                2,
              )
              .having(
                (s) => s.productsState?.data!.last.title,
                'Last Item',
                'Tulip',
              )
              .having((s) => s.nextPage, 'Next Page is null', null),
        ]),
      );

      viewModel.doIntent(FetchProductsEvent());

      await Future.delayed(const Duration(milliseconds: 50));
      viewModel.doIntent(LoadMoreProductsEvent());
    });
  });
}

void _searchTest() {
  group('Search', () {
    test('onSearchSubmitted resets pagination and fetches results', () async {
      when(
        mockUseCase.getProducts(
          search: 'rose',
          page: 1,
          limit: anyNamed('limit'),
          categoryId: anyNamed('categoryId'),
          occasionId: anyNamed('occasionId'),
          sort: anyNamed('sort'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tPage1));

      expectLater(
        viewModel.stream,
        emitsInOrder([
          // 1. Initial state from onSearchSubmitted (manually emitted)
          isA<ProductsStates>()
              .having((s) => s.searchText, 'search text set', 'rose')
              .having(
                (s) => s.productsState?.isLoading,
                'loading reset (manual)',
                true,
              )
              .having((s) => s.currentPage, 'page reset', 1),
          // 2. State from _getAllProducts (when page=1, it emits loading again)
          isA<ProductsStates>().having(
            (s) => s.productsState?.isLoading,
            'loading from getAllProducts',
            true,
          ),
          // 3. Success state
          isA<ProductsStates>()
              .having((s) => s.productsState?.isLoading, 'loading done', false)
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
