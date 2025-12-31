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
  final int _limit = 9;
  bool _isFetchingMore = false;
  bool _hasMore = true;

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
        _hasMore = true;
      }

      _getAllProducts(
        _categoryId,
        _occasionId,
        _sort,
        _search,
        loadMore: !(event.reset || isNewQuery),
      );
    }
  }

  void loadMore() {
    _getAllProducts(_categoryId, _occasionId, _sort, _search);
  }

  void onSearchFocusChanged(bool focused) {
    emit(state.copyWith(isSearchFocused: focused));
    if (!focused && state.searchText.isNotEmpty) {
      _getAllProducts(_categoryId, _occasionId, _sort, state.searchText);
    }
  }

  void onSearchSubmitted(String value) {
    final query = value.trim();
    emit(
      state.copyWith(
        searchText: query,
        productsState: BaseState<List<ProductEntity>>(
          isLoading: true,
        ),
        isSearchFocused: false,
      ),
    );

    _getAllProducts(_categoryId, _occasionId, _sort, query);
  }

  Future<void> _getAllProducts(
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search, {
    bool loadMore = false,
  }) async {
    if (_isFetchingMore || (!_hasMore && loadMore)) return;

    _isFetchingMore = true;

    _handleLoadMore(loadMore);

    BaseResponse<PaginatedProductsEntity> result;

    result = await _handleQurey(categoryId, sort, search, occasionId);

    if (isClosed) return;
    if (result is SuccessResponse<PaginatedProductsEntity>) {
      final newProducts = result.data.products;

      final List<ProductEntity> allProducts = loadMore
          ? [...?state.productsState?.data, ...newProducts]
          : newProducts;

      _hasMore = newProducts.length == _limit;
      if (_hasMore) _page++;

      emit(
        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(
            data: allProducts,
            isLoading: false,
          ),
          isLoadingMore: false,
          hasMore: _hasMore,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: false, hasMore: false));
    }
    _isFetchingMore = false;
  }

  Future<BaseResponse<PaginatedProductsEntity>> _handleQurey(
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

  void _handleLoadMore(bool loadMore) {
    if (!loadMore) {
      _page = 1;
      _hasMore = true;
      emit(
        state.copyWith(
          productsState: BaseState<List<ProductEntity>>(isLoading: true),
          isLoadingMore: false,
          hasMore: true,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
  }
}
