import 'package:flowers_app/Features/order/data/models/checkout/credit/shared_models.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/metadata_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Shared Models Serialization Tests', () {

    test('AdaptivePricing should serialize correctly', () {
      final json = {'enabled': true};
      final model = AdaptivePricing.fromJson(json);
      expect(model.enabled, true);
      expect(model.toJson()['enabled'], true);
    });

    test('AutomaticTax should handle dynamic fields', () {
      final json = {
        'enabled': true,
        'provider': 'stripe',
        'status': 'complete'
      };
      final model = AutomaticTax.fromJson(json);
      expect(model.enabled, true);
      expect(model.provider, 'stripe');
      expect(model.toJson()['status'], 'complete');
    });

    group('Invoice Models Nesting', () {
      test('InvoiceCreation and InvoiceData should parse nested metadata', () {
        final json = {
          'enabled': true,
          'invoice_data': {
            'description': 'Test Invoice',
            'metadata': {'order_id': '123'}
          }
        };

        final model = InvoiceCreation.fromJson(json);

        expect(model.enabled, true);
        expect(model.invoiceData?.description, 'Test Invoice');
        expect(model.invoiceData?.metadata, isA<Metadata>());
      });
    });

    test('PaymentMethodOptions and Card should parse correctly', () {
      final json = {
        'card': {'request_three_d_secure': 'any'}
      };

      final model = PaymentMethodOptions.fromJson(json);

      expect(model.card?.requestThreeDSecure, 'any');

      final resultJson = model.toJson();
      // التصحيح هنا: بما أن explicitToJson غير مفعلة، القيمة هي Instance
      expect(resultJson['card'], isA<Card>());
      expect((resultJson['card'] as Card).requestThreeDSecure, 'any');
    });

    test('Icon and Logo should handle file strings', () {
      final iconJson = {'file': 'icon.png', 'type': 'png'};
      final logoJson = {'file': 'logo.jpg', 'type': 'jpg'};

      final icon = Icon.fromJson(iconJson);
      final logo = Logo.fromJson(logoJson);

      expect(icon.file, 'icon.png');
      expect(logo.type, 'jpg');
    });

    test('PhoneNumberCollection should handle boolean toggle', () {
      final json = {'enabled': false};
      final model = PhoneNumberCollection.fromJson(json);
      expect(model.enabled, false);
    });
  });
}