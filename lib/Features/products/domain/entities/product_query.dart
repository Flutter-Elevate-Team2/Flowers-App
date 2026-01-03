class ProductQuery {
  final String? categoryId;
  final String? occasionId;
  final String? sort;
  final String? search;
  final int page;
  final int limit;

  const ProductQuery({
    this.categoryId,
    this.occasionId,
    this.sort,
    this.search,
    this.page = 1,
    this.limit = 8,
  });

  ProductQuery copyWith({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
    bool resetCategoryId = false,
    bool resetOccasionId = false,
  }) {
    return ProductQuery(
      categoryId: resetCategoryId ? null : (categoryId ?? this.categoryId),
      occasionId: resetOccasionId ? null : (occasionId ?? this.occasionId),
      sort: sort ?? this.sort,
      search: search ?? this.search,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}
