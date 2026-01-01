import 'dart:async';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';

import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsViewModel extends Cubit<ProductsStates> {
  final ProductsUseCase _getProductsUseCase;

  bool isSearchFocused = false;
  String? _categoryId;
  String? _occasionId;
  String? _sort;
  String? _search;

  int _page = 1;
  final int _limit = 8;

  int? _prevPage;
  int? _nextPage;
  int _totalPages = 1;

  ProductsViewModel(this._getProductsUseCase) : super(ProductsStates());

  void doIntent(ProductsEvent event) {
    if (event is FetchProductsEvent) {
      final isNewQuery =
          _sort != event.sort ||
          _categoryId != event.categoryId ||
          _occasionId != event.occasionId ||
          _search != event.search;

      _categoryId = event.categoryId;
      _occasionId = event.occasionId;
      _sort = event.sort;
      _search = event.search;

      if (event.reset || isNewQuery) {
        _page = 1;
        _nextPage = null;
        if (isNewQuery) {
          emit(
            state.copyWith(
              productsState: BaseState<List<ProductEntity>>(isLoading: true),
            ),
          );
        }
      }

      _getAllProducts(_categoryId, _occasionId, _sort, _search);
    } else if (event is LoadMoreProductsEvent) {
      _loadMore();
    } else if (event is NavigateToProductDetailsEvent) {
      emit(state.copyWith(navigateToProduct: event.product));
    }
  }

  void _loadMore() {
    if (state.isPaginationLoading || state.productsState?.isLoading == true)
      return;
    if (_nextPage == null) return;
    _page = _nextPage!;
  void clearNavigation() {
    emit(state.copyWith(navigateToProduct: null));
  }
  void goToPage(int page) {
    if (_totalPages <= 1) return;
    if (page < 1 || page > _totalPages) return;
    if (page == _page) return;

    _page = page;
    _getAllProducts(_categoryId, _occasionId, _sort, _search);
  }

  void onSearchFocusChanged(bool focused) {
    emit(state.copyWith(isSearchFocused: focused));
    if (!focused && state.searchText.isNotEmpty) {
      _page = 1;
      _search = state.searchText;
      _getAllProducts(_categoryId, _occasionId, _sort, state.searchText);
    }
  }

  void onSearchSubmitted(String value) {
    final query = value.trim();
    _page = 1;
    _search = query;
    _prevPage = null;
    _nextPage = null;
    _totalPages = 1;

    emit(
      state.copyWith(
        searchText: query,
        currentPage: 1,
        totalPages: 1,
        prevPage: null,
        nextPage: null,
        productsState: BaseState<List<ProductEntity>>(isLoading: true),
        isSearchFocused: false,
      ),
    );
    _getAllProducts(_categoryId, _occasionId, _sort, query);
  }

  Future<void> _getAllProducts(
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
  ) async {
    if (_page == 1) {
      emit(
        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(isLoading: true),
          isPaginationLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    final result = await _handleQuery(categoryId, sort, search, occasionId);

    if (isClosed) return;

    if (result is SuccessResponse<PaginatedProductsEntity>) {
      final data = result.data;

      final hasSearch = search != null && search.isNotEmpty;
      final productsCount = data.products.length;

      final shouldPaginate = !hasSearch || productsCount >= _limit;

      _totalPages = shouldPaginate ? data.meta.totalPages : 1;
      _prevPage = shouldPaginate ? data.meta.prevPage : null;
      _nextPage = shouldPaginate ? data.meta.nextPage : null;

      List<ProductEntity> allProducts = [];
      if (_page == 1) {
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
          currentPage: _page,
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
          productsState: _page == 1
              ? BaseState<List<ProductEntity>>(
                  errorMessage: 'Failed to load products',
                )
              : state.productsState,
        ),
      );
    }
  }

  Future<BaseResponse<PaginatedProductsEntity>> _handleQuery(
    String? categoryId,
    String? sort,
    String? search,
    String? occasionId,
  ) async {
    if (categoryId != null && categoryId.isNotEmpty) {
      return await _getProductsUseCase.getProducts(
        categoryId: categoryId,
        sort: sort,
        search: search,
        page: _page,
        limit: _limit,
      );
    } else if (occasionId != null && occasionId.isNotEmpty) {
      return await _getProductsUseCase.getProducts(
        occasionId: occasionId,
        sort: sort,
        search: search,
        page: _page,
        limit: _limit,
      );
    } else {
      return await _getProductsUseCase.getProducts(
        sort: sort,
        search: search,
        page: _page,
        limit: _limit,
      );
    }
  }
}
