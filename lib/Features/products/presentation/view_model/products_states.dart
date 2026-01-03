import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class ProductsStates {
  final BaseState<List<ProductEntity>>? productsState;
  final bool isSearchFocused;
  final String searchText;
  final int currentPage;
  final int totalPages;
  final int? prevPage;
  final int? nextPage;
  final ProductEntity? navigateToProduct;

  final bool isPaginationLoading;

  ProductsStates({
    this.productsState,
    this.isSearchFocused = false,
    this.searchText = '',
    this.currentPage = 1,
    this.totalPages = 1,
    this.prevPage,
    this.nextPage,
    this.isPaginationLoading = false,
    this.navigateToProduct,
  });

  ProductsStates copyWith({
    BaseState<List<ProductEntity>>? productsState,
    bool? isSearchFocused,
    String? searchText,
    int? currentPage,
    int? totalPages,
    int? prevPage,
    int? nextPage,
    bool? isPaginationLoading,
    bool resetNextPage = false,
    ProductEntity? navigateToProduct,
  }) {
    return ProductsStates(
      productsState: productsState ?? this.productsState,
      isSearchFocused: isSearchFocused ?? this.isSearchFocused,
      searchText: searchText ?? this.searchText,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      prevPage: prevPage,
      nextPage: nextPage,
      navigateToProduct: navigateToProduct,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}
