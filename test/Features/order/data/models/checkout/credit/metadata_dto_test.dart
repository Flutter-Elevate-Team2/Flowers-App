import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/metadata_dto.dart';

void main() {
  group('Metadata DTO Tests', () {
    test('should parse metadata from JSON correctly', () {
      final json = {
        'city': 'Cairo',
        'lat': '30.0444',
        'long': '31.2357',
        'phone': '0123456789',
        'street': 'Tahrir Square'
      };

      final result = Metadata.fromJson(json);

      expect(result.city, 'Cairo');
      expect(result.street, 'Tahrir Square');
      expect(result.lat, '30.0444');
    });

    test('should handle empty or null fields', () {
      final json = {'city': 'Alex'};
      final result = Metadata.fromJson(json);

      expect(result.city, 'Alex');
      expect(result.phone, isNull);
    });

    test('should return valid JSON map from toJson()', () {
      final metadata = Metadata(city: 'Giza', phone: '011');
      final json = metadata.toJson();

      expect(json['city'], 'Giza');
      expect(json['phone'], '011');
    });
  });
}