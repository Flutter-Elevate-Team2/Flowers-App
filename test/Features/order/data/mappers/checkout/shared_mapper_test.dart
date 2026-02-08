import 'package:flowers_app/Features/order/data/mappers/checkout/shared_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/customer_details_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/metadata_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/shared_models.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/total_details_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/adaptive_pricing_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/customer_details_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/payment_method_options.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/total_details_entity.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TODO: Implement tests for AdaptivePricingMapper', () {

    // Arrange
    final adaptivePricing = AdaptivePricing(enabled: true);
  // Assert
  final entity = adaptivePricing.toEntity();
    // Act

    // Assert
    expect(entity, isA<AdaptivePricingEntity>());
    expect(entity.enabled, true);
  });

  test('CustomerDetailsMapper maps correctly', () {
    final dto = CustomerDetails(email: 'test@example.com');

    final entity = dto.toEntity();

    expect(entity, isA<CustomerDetailsEntity>());
    expect(entity.email, 'test@example.com');
  });
  test('PaymentMethodOptionsMapper maps correctly', () {
    final dto = PaymentMethodOptions();

    final entity = dto.toEntity();

    expect(entity, isA<PaymentMethodOptionsEntity>());
  });

  test('TotalDetailsMapper maps correctly', () {
    final dto = TotalDetails(
      amountDiscount: 100,
      amountTax: 50,
      amountShipping: 20,
    );

    final entity = dto.toEntity();

    expect(entity, isA<TotalDetailsEntity>());
    expect(entity.amountDiscount, 100);
    expect(entity.amountTax, 50);
    expect(entity.amountShipping, 20);
  });

  test('MetadataMapper maps correctly', () {
    final dto = Metadata(
      city: 'Cairo',
      street: 'Nile St',
      phone: '0123456789',
      long: "31.2",
      lat: "30.0",
    );

    final entity = dto.toEntity();

    expect(entity, isA<MetadataEntity>());
    expect(entity.city, 'Cairo');
    expect(entity.street, 'Nile St');
    expect(entity.phone, '0123456789');
    expect(entity.long, "31.2");
    expect(entity.lat, "30.0");
  });

}