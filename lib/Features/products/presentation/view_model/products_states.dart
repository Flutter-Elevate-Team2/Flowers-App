import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class ProductsStates {
  final BaseState<List<ProductEntity>>? productsState;
  final bool isSearchFocused;
  final String searchText;
  final bool isLoadingMore;
  final bool hasMore;

  ProductsStates({
    this.productsState,
    this.isSearchFocused = false,
    this.searchText = '',
    this.isLoadingMore = false,
    this.hasMore = true,
  });
  ProductsStates copyWith({
    BaseState<List<ProductEntity>>? productsState,
    bool? isSearchFocused,
    String? searchText,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return ProductsStates(
      productsState: productsState,
      isSearchFocused: isSearchFocused ?? this.isSearchFocused,
      searchText: searchText ?? this.searchText,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
