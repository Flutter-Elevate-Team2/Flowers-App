import 'dart:async';

import 'package:flowers_app/Features/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/home/domain/use_cases/get_home_sections_use_case.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/Features/products/domain/entities/product_query.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsViewModel extends Cubit<ProductsStates> {
  final ProductsUseCase _getProductsUseCase;
  final GetHomeSectionsUseCase _getHomeSectionsUseCase;

  ProductQuery _query = const ProductQuery();

  int _totalPages = 1;
  int? _prevPage;
  int? _nextPage;

  ProductsViewModel(this._getProductsUseCase, this._getHomeSectionsUseCase)
    : super(ProductsStates());

  void doIntent(ProductsEvent event) {
    if (event is FetchProductsEvent) {
      final isNewQuery =
          _query.sort != event.sort ||
          _query.categoryId != event.categoryId ||
          _query.occasionId != event.occasionId ||
          _query.search != event.search;

      if (event.reset || isNewQuery) {
        _query = const ProductQuery();
        _nextPage = null;
        _prevPage = null;
        _totalPages = 1;
      }

      _query = _query.copyWith(
        categoryId: event.categoryId,
        occasionId: event.occasionId,
        sort: event.sort,
        search: event.search,
        page: 1,
        resetCategoryId: event.categoryId == '' ? true : false,
        resetOccasionId: event.occasionId == '' ? true : false,
      );

      _getAllProducts();
    } else if (event is LoadMoreProductsEvent) {
      _loadMore();
    } else if (event is FetchCategoriesEvent) {
      _fetchCategories();
    } else if (event is FetchOccasionsEvent) {
      _fetchOccasions();
    }
  }

  void _loadMore() {
    if (state.isPaginationLoading || state.productsState?.isLoading == true) {
      return;
    }
    if (_nextPage == null) return;

    _query = _query.copyWith(page: _nextPage);
    _getAllProducts();
  }

  void goToPage(int page) {
    if (_totalPages <= 1) return;
    if (page < 1 || page > _totalPages) return;
    if (page == _query.page) return;

    _query = _query.copyWith(page: page);
    _getAllProducts();
  }

  void onSearchFocusChanged(bool focused) {
    emit(state.copyWith(isSearchFocused: focused));
    if (!focused && state.searchText.isNotEmpty) {
      _query = _query.copyWith(search: state.searchText, page: 1);
      _getAllProducts();
    }
  }

  void onSearchSubmitted(String value) {
    final queryText = value.trim();
    _prevPage = null;
    _nextPage = null;
    _totalPages = 1;

    emit(
      state.copyWith(
        searchText: queryText,
        currentPage: 1,
        totalPages: 1,
        prevPage: null,
        nextPage: null,
        productsState: BaseState<List<ProductEntity>>(isLoading: true),
        isSearchFocused: false,
      ),
    );
    _query = _query.copyWith(search: queryText, page: 1);
    _getAllProducts();
  }

  Future<void> _getAllProducts() async {
    if (_query.page == 1) {
      emit(
        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(isLoading: true),
          isPaginationLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    final result = await _handleQuery();

    if (isClosed) return;

    if (result is SuccessResponse<PaginatedProductsEntity>) {
      final data = result.data;

      final hasSearch = _query.search != null && _query.search!.isNotEmpty;
      final productsCount = data.products.length;

      final shouldPaginate = !hasSearch || productsCount >= _query.limit;

      _totalPages = shouldPaginate ? data.meta.totalPages : 1;
      _prevPage = shouldPaginate ? data.meta.prevPage : null;
      _nextPage = shouldPaginate ? data.meta.nextPage : null;

      List<ProductEntity> allProducts = [];
      if (_query.page == 1) {
        allProducts = data.products;
      } else {
        final currentList = state.productsState?.data ?? [];
        allProducts = [...currentList, ...data.products];
      }

      emit(
        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(
            data: allProducts,
            isLoading: false,
          ),
          currentPage: _query.page,
          totalPages: _totalPages,
          prevPage: _prevPage,
          nextPage: _nextPage,
          resetNextPage: _nextPage == null,
          isPaginationLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isPaginationLoading: false,
          productsState: _query.page == 1
              ? BaseState<List<ProductEntity>>(
                  errorMessage: 'Failed to load products',
                )
              : state.productsState,
        ),
      );
    }
  }

  Future<BaseResponse<PaginatedProductsEntity>> _handleQuery() async {
    if (_query.categoryId != null && _query.categoryId!.isNotEmpty) {
      return await _getProductsUseCase.getProducts(
        categoryId: _query.categoryId,
        sort: _query.sort,
        search: _query.search,
        page: _query.page,
        limit: _query.limit,
      );
    } else if (_query.occasionId != null && _query.occasionId!.isNotEmpty) {
      return await _getProductsUseCase.getProducts(
        occasionId: _query.occasionId,
        sort: _query.sort,
        search: _query.search,
        page: _query.page,
        limit: _query.limit,
      );
    } else {
      return await _getProductsUseCase.getProducts(
        sort: _query.sort,
        search: _query.search,
        page: _query.page,
        limit: _query.limit,
      );
    }
  }

  Future<void> _fetchCategories() async {
    emit(
      state.copyWith(
        categoriesState: BaseState<List<CategoryEntity>>(isLoading: true),
      ),
    );

    final result = await _getHomeSectionsUseCase.call();

    if (result is SuccessResponse<HomeEntity>) {
      emit(
        state.copyWith(
          categoriesState: BaseState<List<CategoryEntity>>(
            data: result.data.categories,
            isLoading: false,
          ),
        ),
      );
    } else if (result is ErrorResponse<HomeEntity>) {
      emit(
        state.copyWith(
          categoriesState: BaseState<List<CategoryEntity>>(
            errorMessage: result.errorMessage,
            isLoading: false,
          ),
        ),
      );
    }
  }

  Future<void> _fetchOccasions() async {
    emit(
      state.copyWith(
        occasionsState: BaseState<List<OccasionEntity>>(isLoading: true),
      ),
    );

    final result = await _getHomeSectionsUseCase.call();

    if (result is SuccessResponse<HomeEntity>) {
      emit(
        state.copyWith(
          occasionsState: BaseState<List<OccasionEntity>>(
            data: result.data.occasions,
            isLoading: false,
          ),
        ),
      );
    } else if (result is ErrorResponse<HomeEntity>) {
      emit(
        state.copyWith(
          occasionsState: BaseState<List<OccasionEntity>>(
            errorMessage: result.errorMessage,
            isLoading: false,
          ),
        ),
      );
    }
  }
}
