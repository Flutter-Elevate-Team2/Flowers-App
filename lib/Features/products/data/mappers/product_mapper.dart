import 'package:flowers_app/Features/products/data/models/products_model/products_dto.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';

extension ProductMapper on Products {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity ?? 0,
      categoryId: category ?? '',
      occasionId: occasion ?? '',
      sold: sold ?? 0,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
      isInWishlist: isInWishlist ?? false,
      discount: discount ?? 0,
    );
  }
}
