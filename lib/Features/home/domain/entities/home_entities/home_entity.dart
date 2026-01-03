import 'package:flowers_app/Features/home/domain/entities/home_entities/bestseller_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';

class HomeEntity {
  final List<CategoryEntity> categories;
  final List<BestSellerEntity> bestSellers;
  final List<OccasionEntity> occasions;

  HomeEntity({
    required this.categories,
    required this.bestSellers,
    required this.occasions,
  });
}
