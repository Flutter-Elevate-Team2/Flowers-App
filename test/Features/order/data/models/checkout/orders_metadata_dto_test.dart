import 'package:flowers_app/Features/order/data/models/checkout/orders_metadata_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Orders Metadata DTO Tests', () {

    test('should parse pagination metadata from JSON correctly', () {
      final json = {
        'currentPage': 1,
        'totalPages': 10,
        'limit': 20,
        'totalItems': 200,
      };

      final result = Metadata.fromJson(json);

      expect(result.currentPage, 1);
      expect(result.totalPages, 10);
      expect(result.limit, 20);
      expect(result.totalItems, 200);
    });

    test('should return null for missing fields in JSON', () {
      final json = {'currentPage': 1};
      final result = Metadata.fromJson(json);

      expect(result.currentPage, 1);
      expect(result.totalPages, isNull);
    });

    test('should convert Metadata object to valid JSON', () {
      final metadata = Metadata(
        currentPage: 2,
        totalPages: 5,
        limit: 10,
        totalItems: 50,
      );

      final json = metadata.toJson();

      expect(json['currentPage'], 2);
      expect(json['totalItems'], 50);
    });
  });
}