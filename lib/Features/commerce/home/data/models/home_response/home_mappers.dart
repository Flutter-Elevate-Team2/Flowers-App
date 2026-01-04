import 'package:flowers_app/Features/commerce/home/data/models/home_response/best_seller.dart';
import 'package:flowers_app/Features/commerce/home/data/models/home_response/category.dart';
import 'package:flowers_app/Features/commerce/home/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/home/data/models/home_response/occasion.dart';
import 'package:flowers_app/Features/commerce/home/domain/entities/best_seller_entity.dart';
import 'package:flowers_app/Features/commerce/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/home/domain/entities/home_entities/occasion_entity.dart';

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
  BestSellerEntity toEntity() {
    return BestSellerEntity(
      id: id ?? '',
      name: title ?? '',
      price: price?.toDouble() ?? 0.0,
      imageUrl: imgCover ?? '',
      description: description ?? '',
      images: images ?? [],
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity ?? 0,
      discount: discount ?? 0,
    );
  }
}

extension HomeResponseMapper on HomeResponse {
  HomeEntity toEntity() {
    return HomeEntity(
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
      bestSellers: bestSeller?.map((e) => e.toEntity()).toList() ?? [],
      occasions: occasions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
