import 'package:flowers_app/Features/order/data/mappers/checkout/session_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/customer_details_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/metadata_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/session_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/shared_models.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/total_details_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/adaptive_pricing_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/customer_details_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/payment_method_options.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/total_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TODO: Implement tests for session_mapper.dart', () {

        // Arrange
        final session = Session(
          id: 'id_123',
          amountTotal: 5000,
          currency: 'usd',
          paymentStatus: 'paid',
          url: 'https://example.com/checkout',
          cancelUrl: 'https://example.com/cancel',
          successUrl: 'https://example.com/success',
          status: 'complete',
          created: 1625247600,
          object: 'checkout.session',
          uiMode: 'payment',
          amountSubtotal: 4500,
          expiresAt: 1625251200,
          mode: 'payment',
          livemode: false,
          clientReferenceId: 'client_ref_123',
          customerEmail: "",
          paymentMethodCollection: "automatic",
          adaptivePricing: AdaptivePricing(),
          customerDetails: CustomerDetails(),
          paymentMethodOptions: PaymentMethodOptions(),
          metadata: Metadata(),
          totalDetails: TotalDetails(),
          discounts: [],
        );

        // Act
        final entity = session.toEntity();

        // Assert
        expect(entity, isA<SessionEntity>());
        expect(entity.id, 'id_123');
        expect(entity.amountTotal, 5000);
        expect(entity.currency, 'usd');
        expect(entity.paymentStatus, 'paid');
        expect(entity.status, 'complete');
        expect(entity.liveMode, false);
        expect(entity.customerEmail, '');
        expect(entity.url, 'https://example.com/checkout');
        expect(entity.cancelUrl, 'https://example.com/cancel');
        expect(entity.successUrl, 'https://example.com/success');
        expect(entity.created, 1625247600);
        expect(entity.object, 'checkout.session');
        expect(entity.uiMode, 'payment');
        expect(entity.amountSubtotal, 4500);
        expect(entity.expiresAt, 1625251200);
        expect(entity.mode, 'payment');
        expect(entity.clientReferenceId, 'client_ref_123');
        expect(entity.paymentMethodCollection, 'automatic');
        expect(entity.adaptivePricing, isA<AdaptivePricingEntity>());
        expect(entity.customerDetails, isA<CustomerDetailsEntity>());
        expect(entity.paymentMethodOptions, isA<PaymentMethodOptionsEntity>());
        expect(entity.metadata, isA<MetadataEntity>());
        expect(entity.totalDetails, isA<TotalDetailsEntity>());

  });
    }