import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/total_details_dto.dart';

void main() {
  group('TotalDetails DTO Tests', () {
    test('should parse total details from JSON correctly', () {
      final json = {
        'amount_discount': 500,
        'amount_shipping': 1000,
        'amount_tax': 200
      };

      final result = TotalDetails.fromJson(json);

      expect(result.amountDiscount, 500);
      expect(result.amountShipping, 1000);
      expect(result.amountTax, 200);
    });

    test('should handle null values in JSON', () {
      final json = {'amount_discount': 0};
      final result = TotalDetails.fromJson(json);

      expect(result.amountDiscount, 0);
      expect(result.amountShipping, isNull);
      expect(result.amountTax, isNull);
    });

    test('should return valid JSON map from toJson()', () {
      final details = TotalDetails(amountDiscount: 100, amountShipping: 50);
      final json = details.toJson();

      expect(json['amount_discount'], 100);
      expect(json['amount_shipping'], 50);
    });
  });
}