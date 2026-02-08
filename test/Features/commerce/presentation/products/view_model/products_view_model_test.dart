import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/meta_data_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/domain/use_cases/get_home_sections_use_case.dart';
import 'package:flowers_app/Features/commerce/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_view_model_test.mocks.dart';

@GenerateMocks([ProductsUseCase, GetHomeSectionsUseCase])
void main() {
  late ProductsViewModel viewModel;
  late MockProductsUseCase mockProductsUseCase;
  late MockGetHomeSectionsUseCase mockGetHomeSectionsUseCase;

  setUp(() {
    provideDummy<BaseResponse<PaginatedProductsEntity>>(
      SuccessResponse(
        data: PaginatedProductsEntity(
          products: [],
          meta: MetaDataEntity(
            limit: 10,
            totalItems: 0,
            totalPages: 0,
            currentPage: 1,
            nextPage: null,
            prevPage: null,
          ),
        ),
      ),
    );
    provideDummy<BaseResponse<HomeEntity>>(
      SuccessResponse(
        data: HomeEntity(categories: [], occasions: [], bestSellers: []),
      ),
    );

    mockProductsUseCase = MockProductsUseCase();
    mockGetHomeSectionsUseCase = MockGetHomeSectionsUseCase();
    viewModel = ProductsViewModel(
      mockProductsUseCase,
      mockGetHomeSectionsUseCase,
    );
  });

  tearDown(() {
    viewModel.close();
  });

  group('ProductsViewModel', () {
    final tProduct = ProductEntity(
      id: "1",
      title: "Rose",
      imgCover: "image.png",
      price: 100,
      slug: "rose-flower",
      description: "A beautiful rose",
      images: ["image1.png", "image2.png"],
      priceAfterDiscount: 90,
      quantity: 10,
      categoryId: "cat1",
      occasionId: "occ1",
      sold: 5,
      rateAvg: 4,
      rateCount: 10,
      isInWishlist: false,
      discount: 10,
    );
    final tPaginatedProducts = PaginatedProductsEntity(
      products: [tProduct],
      meta: MetaDataEntity(
        totalItems: 1,
        currentPage: 1,
        limit: 10,
        totalPages: 1,
        prevPage: null,
        nextPage: null,
      ),
    );

    final tCategory = CategoryEntity(id: "1", name: "Flowers", icon: "");
    final tOccasion = OccasionEntity(id: "1", name: "Wedding", imageUrl: "");
    final tHomeEntity = HomeEntity(
      categories: [tCategory],
      occasions: [tOccasion],
      bestSellers: [],
    );

    test('initial state is correct', () {
      expect(viewModel.state.isPaginationLoading, false);
      expect(viewModel.state.productsState, isNull);
    });

    // Test FetchProductsEvent
    blocTest<ProductsViewModel, ProductsStates>(
      'emits [isLoading, Success] when FetchProductsEvent is added and useCase succeeds',
      build: () {
        when(
          mockProductsUseCase.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
            search: anyNamed('search'),
            page: anyNamed('page'),
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => SuccessResponse(data: tPaginatedProducts));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(FetchProductsEvent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        predicate<ProductsStates>(
          (state) => state.productsState?.isLoading == true,
        ),
        predicate<ProductsStates>(
          (state) =>
              state.productsState?.isLoading == false &&
              state.productsState?.data?.length ==
                  tPaginatedProducts.products.length &&
              state.totalPages == 1,
        ),
      ],
    );

    blocTest<ProductsViewModel, ProductsStates>(
      'emits [isLoading, Error] when FetchProductsEvent is added and useCase fails',
      build: () {
        when(
          mockProductsUseCase.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
            search: anyNamed('search'),
            page: anyNamed('page'),
            limit: anyNamed('limit'),
          ),
        ).thenAnswer(
          (_) async => ErrorResponse(errorMessage: 'Failed to fetch'),
        );
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(FetchProductsEvent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        predicate<ProductsStates>(
          (state) => state.productsState?.isLoading == true,
        ),
        predicate<ProductsStates>(
          (state) =>
              state.productsState?.isLoading == false &&
              state.productsState?.errorMessage == 'Failed to load products',
        ),
      ],
    );

    // Test FetchCategoriesEvent
    blocTest<ProductsViewModel, ProductsStates>(
      'emits [isLoading, Success] for categories when FetchCategoriesEvent is added',
      build: () {
        when(
          mockGetHomeSectionsUseCase.call(),
        ).thenAnswer((_) async => SuccessResponse(data: tHomeEntity));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(FetchCategoriesEvent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        predicate<ProductsStates>(
          (state) => state.categoriesState?.isLoading == true,
        ),
        predicate<ProductsStates>(
          (state) =>
              state.categoriesState?.isLoading == false &&
              state.categoriesState?.data == tHomeEntity.categories,
        ),
      ],
    );

    // Test Pagination (LoadMore)
    blocTest<ProductsViewModel, ProductsStates>(
      'loads more products when next page exists (Simulated flow)',
      build: () {
        // 1. Setup response for Page 1 (sets _nextPage = 2 internally)
        final tPage1Meta = MetaDataEntity(
          totalItems: 2,
          currentPage: 1,
          limit: 10,
          totalPages: 2,
          prevPage: null,
          nextPage: 2,
        );
        final tPage1Products = PaginatedProductsEntity(
          products: [tProduct],
          meta: tPage1Meta,
        );

        // 2. Setup response for Page 2
        final tPage2Meta = MetaDataEntity(
          totalItems: 2,
          currentPage: 2,
          limit: 10,
          totalPages: 2,
          prevPage: 1,
          nextPage: null,
        );
        final tPage2Products = PaginatedProductsEntity(
          products: [tProduct],
          meta: tPage2Meta,
        );

        when(
          mockProductsUseCase.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
            search: anyNamed('search'),
            page: 1,
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => SuccessResponse(data: tPage1Products));

        when(
          mockProductsUseCase.getProducts(
            categoryId: anyNamed('categoryId'),
            occasionId: anyNamed('occasionId'),
            sort: anyNamed('sort'),
            search: anyNamed('search'),
            page: 2,
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => SuccessResponse(data: tPage2Products));

        return viewModel;
      },
      act: (bloc) async {
        // Trigger Page 1 fetch to initialize private fields (_nextPage etc)
        bloc.doIntent(FetchProductsEvent());
        await Future.delayed(const Duration(milliseconds: 300));
        // Now Trigger LoadMore
        bloc.doIntent(LoadMoreProductsEvent());
      },
      wait: const Duration(milliseconds: 600),
      expect: () => [
        // Page 1 States
        predicate<ProductsStates>(
          (state) => state.productsState?.isLoading == true,
        ),
        predicate<ProductsStates>(
          (state) =>
              state.productsState?.isLoading == false &&
              state.productsState!.data!.length == 1 &&
              state.nextPage == 2,
        ),
        // Page 2 States
        predicate<ProductsStates>((state) => state.isPaginationLoading == true),
        predicate<ProductsStates>(
          (state) =>
              state.isPaginationLoading == false &&
              state.productsState!.data!.length == 2 &&
              state.currentPage == 2,
        ),
      ],
    );
  });
}
