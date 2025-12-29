class ProductsEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String categoryId;
  final String occasionId;
  final int sold;
  final int rateAvg;
  final int rateCount;
  final bool isInWishlist;

  ProductsEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.categoryId,
    required this.occasionId,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
    required this.isInWishlist,
  });
}
