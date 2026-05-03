import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartRequest Model Tests', () {
    test('should convert from JSON correctly', () {
      final Map<String, dynamic> jsonMap = {
        'product': 'flower_id_123',
        'quantity': 2,
      };

      final result = CartRequest.fromJson(jsonMap);

      expect(result.product, 'flower_id_123');
      expect(result.quantity, 2);
    });

    test('should convert to JSON correctly', () {
      final request = CartRequest(product: '123', quantity: 5);

      final result = request.toJson();

      expect(result['product'], '123');
      expect(result['quantity'], 5);
    });
  });
}