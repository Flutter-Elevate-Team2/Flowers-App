import 'package:flowers_app/Features/order/data/models/checkout/credit/customer_details_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/metadata_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/shared_models.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/total_details_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/adaptive_pricing_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/customer_details_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/payment_method_options.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/total_details_entity.dart';

extension AdaptivePricingMapper on AdaptivePricing {
  AdaptivePricingEntity toEntity() {
    return AdaptivePricingEntity(enabled: enabled);
  }
}

extension CustomerDetailsMapper on CustomerDetails {
  CustomerDetailsEntity toEntity() {
    return CustomerDetailsEntity(email: email);
  }
}

extension PaymentMethodOptionsMapper on PaymentMethodOptions {
  PaymentMethodOptionsEntity toEntity() {
    return const PaymentMethodOptionsEntity();
  }
}

extension TotalDetailsMapper on TotalDetails {
  TotalDetailsEntity toEntity() {
    return TotalDetailsEntity(
      amountDiscount: amountDiscount,
      amountTax: amountTax,
      amountShipping: amountShipping,
    );
  }
}

extension MetadataMapper on Metadata {
  MetadataEntity toEntity() {
    return MetadataEntity(
      city: city,
      street: street,
      phone: phone,
      long: long,
      lat: lat,
    );
  }
}
