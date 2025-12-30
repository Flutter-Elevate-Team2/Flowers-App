import 'package:flowers_app/Features/products/domain/entities/products_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class ProductsStates {

    final BaseState<List<ProductsEntity>>? productsState;
    final bool isSearchFocused;
    final String searchText;


    ProductsStates({this.productsState , this.isSearchFocused = false , this.searchText =''});
    ProductsStates copyWith({
        BaseState<List<ProductsEntity>>? productsState,
        bool? isSearchFocused,
        String? searchText,
    }) {
        return ProductsStates(
            productsState: productsState ,
            isSearchFocused: isSearchFocused ?? this.isSearchFocused,
            searchText: searchText ?? this.searchText,
        );
    }
}