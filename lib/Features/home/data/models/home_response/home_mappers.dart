import 'package:flowers_app/Features/home/data/models/home_response/best_seller.dart';
import 'package:flowers_app/Features/home/data/models/home_response/category.dart';
import 'package:flowers_app/Features/home/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/home/data/models/home_response/occasion.dart';
import 'package:flowers_app/Features/home/data/models/home_response/product.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/product_entity.dart';

extension ProductMapper on Product {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      name: title ?? '',
      price: price?.toDouble() ?? 0.0,
      imageUrl: imgCover ?? '',
    );
  }
}

extension CategoryMapper on Category {
  CategoryEntity toEntity() {
    return CategoryEntity(id: id ?? '', name: name ?? '', icon: image ?? '');
  }
}

extension OccasionMapper on Occasion {
  OccasionEntity toEntity() {
    return OccasionEntity(
      id: id ?? '',
      name: name ?? '',
      imageUrl: image ?? '',
    );
  }
}

extension BestSellerMapper on BestSeller {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      name: title ?? '',
      price: price?.toDouble() ?? 0.0,
      imageUrl: imgCover ?? '',
    );
  }
}

extension HomeResponseMapper on HomeResponse {
  HomeEntity toEntity() {
    return HomeEntity(
      products: products?.map((e) => e.toEntity()).toList() ?? [],
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
      bestSellers: bestSeller?.map((e) => e.toEntity()).toList() ?? [],
      occasions: occasions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
