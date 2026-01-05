import 'package:flowers_app/Features/commerce/data/mappers/home_mappers.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/best_seller.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/category.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/occasion.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/best_seller_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeMappers Tests', () {
    test('should map Category to CategoryEntity correctly', () {
      final category = Category(id: '1', name: 'Roses', image: 'roses.png');

      final CategoryEntity entity = category.toEntity();

      expect(entity.id, '1');
      expect(entity.name, 'Roses');
      expect(entity.icon, 'roses.png');
    });

    test('should map Occasion to OccasionEntity correctly', () {
      final occasion = Occasion(
        id: '1',
        name: 'Birthday',
        image: 'birthday.png',
      );

      final OccasionEntity entity = occasion.toEntity();

      expect(entity.id, '1');
      expect(entity.name, 'Birthday');
      expect(entity.imageUrl, 'birthday.png');
    });

    test('should map BestSeller to BestSellerEntity correctly', () {
      final bestSeller = BestSeller(
        id: '1',
        title: 'Rose Bouquet',
        slug: 'rose-bouquet',
        description: 'Beautiful roses',
        imgCover: 'roses.png',
        images: ['img1.png', 'img2.png'],
        price: 100,
        priceAfterDiscount: 80,
        quantity: 10,
        category: '123',
        occasion: '456',
        sold: 5,
        rateAvg: 4,
        rateCount: 10,
        discount: 20,
      );

      final BestSellerEntity entity = bestSeller.toEntity();

      expect(entity.id, '1');
      expect(entity.name, 'Rose Bouquet');
      expect(entity.description, 'Beautiful roses');
      expect(entity.imageUrl, 'roses.png');
      expect(entity.images.length, 2);
      expect(entity.price, 100.0);
      expect(entity.priceAfterDiscount, 80);
      expect(entity.quantity, 10);
      expect(entity.discount, 20);
    });

    test('should map HomeResponse to HomeEntity correctly', () {
      final homeResponse = HomeResponse(
        message: 'Success',
        categories: [Category(id: '1', name: 'Roses', image: 'roses.png')],
        occasions: [Occasion(id: '1', name: 'Birthday', image: 'birthday.png')],
        bestSeller: [
          BestSeller(
            id: '1',
            title: 'Rose Bouquet',
            slug: 'rose-bouquet',
            description: 'Beautiful roses',
            imgCover: 'roses.png',
            images: ['img1.png'],
            price: 100,
            priceAfterDiscount: 80,
            quantity: 10,
            category: '123',
            occasion: '456',
            sold: 5,
            rateAvg: 4,
            rateCount: 10,
            discount: 20,
          ),
        ],
      );

      final HomeEntity entity = homeResponse.toEntity();

      expect(entity.categories.length, 1);
      expect(entity.occasions.length, 1);
      expect(entity.bestSellers.length, 1);
      expect(entity.categories.first.name, 'Roses');
      expect(entity.occasions.first.name, 'Birthday');
      expect(entity.bestSellers.first.name, 'Rose Bouquet');
    });

    test('should handle null values in HomeResponse correctly', () {
      final homeResponse = HomeResponse();

      final HomeEntity entity = homeResponse.toEntity();

      expect(entity.categories, isEmpty);
      expect(entity.occasions, isEmpty);
      expect(entity.bestSellers, isEmpty);
    });
  });
}
