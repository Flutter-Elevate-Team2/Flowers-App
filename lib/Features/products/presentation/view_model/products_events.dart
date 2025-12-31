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
  final ProductsEvent product;

  NavigateToProductDetailsEvent(this.product);
}

