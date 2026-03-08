import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/session_dto.dart';

void main() {
  group('CreditCheckoutResponseModel Serialization Tests', () {

     final tSessionJson = {
      'id': 'cs_test_123',
      'object': 'checkout.session',
      'amount_total': 1500,
      'currency': 'egp',
      'url': 'https://checkout.stripe.com/pay/test_session',
      'status': 'open',
      'payment_status': 'unpaid',
    };

    final tResponseJson = {
      'message': 'success',
      'session': tSessionJson,
    };

    test('should create CreditCheckoutResponseModel from JSON', () {
      // Act
      final result = CreditCheckoutResponseModel.fromJson(tResponseJson);

      // Assert
      expect(result.message, 'success');
      expect(result.session?.id, 'cs_test_123');
      expect(result.session?.amountTotal, 1500);
      expect(result.session?.url, contains('stripe.com'));
    });

    test('should handle null session gracefully', () {
      final jsonWithNullSession = {'message': 'error', 'session': null};

      final result = CreditCheckoutResponseModel.fromJson(jsonWithNullSession);

      expect(result.session, isNull);
      expect(result.message, 'error');
    });

     test('should convert model back to JSON (toJson)', () {
       // Arrange
       final session = Session(id: 'sess_999', url: 'https://test.com');
       final model = CreditCheckoutResponseModel(message: 'done', session: session);

       // Act
       final json = model.toJson();

       // Assert
       expect(json['message'], 'done');

      final sessionMap = (json['session'] as Session).toJson();
       expect(sessionMap['id'], 'sess_999');
     });  });
}