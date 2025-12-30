sealed class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {
  String categoryId;
  String occasionId;
  String sort;
  String search;
  FetchProductsEvent({
    this.categoryId = '',
    this.occasionId = '',
    this.sort = '',
    this.search = '',
  });
}
