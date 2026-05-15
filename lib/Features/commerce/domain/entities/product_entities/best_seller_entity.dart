class BestSellerEntity {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final List<String> images;
  final num priceAfterDiscount;
  final num quantity;
  final String description;
  final num discount;

  BestSellerEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.images,
    required this.priceAfterDiscount,
    required this.quantity, required this.discount,
  });
}
