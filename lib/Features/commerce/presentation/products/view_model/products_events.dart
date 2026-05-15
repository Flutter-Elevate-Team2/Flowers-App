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

class FetchCategoriesEvent extends ProductsEvent {}

class FetchOccasionsEvent extends ProductsEvent {}

class FetchBestSellersEvent extends ProductsEvent {}
