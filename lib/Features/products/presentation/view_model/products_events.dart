import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';

sealed class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {
  String categoryId;
  String occasionId;
  String sort;
  String search;
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

