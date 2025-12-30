import 'package:flowers_app/Features/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/product_entity.dart';

class HomeEntity  {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final List<ProductEntity> bestSellers;
  final List<OccasionEntity> occasions;

  HomeEntity({
    required this.products,
    required this.categories,
    required this.bestSellers,
    required this.occasions,
  });
}