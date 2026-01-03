import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';

sealed class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {
  final String categoryId;
  final String occasionId;
  final String sort;
  final String search;
  final bool reset;

  FetchProductsEvent({
    this.categoryId = '',
    this.occasionId = '',
    this.sort = '',
    this.search = '',
    this.reset = false,
  });


}

class LoadMoreProductsEvent extends ProductsEvent {}

class NavigateToProductDetailsEvent extends ProductsEvent {
  final ProductEntity product;

  NavigateToProductDetailsEvent(this.product);
}

class FetchCategoriesEvent extends ProductsEvent {}

class FetchOccasionsEvent extends ProductsEvent {}