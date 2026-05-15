import 'package:flowers_app/Features/order/data/mappers/checkout/shared_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/session_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';

extension SessionMapper on Session {
  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      amountTotal: amountTotal,
      currency: currency,
      paymentStatus: paymentStatus,
      url: url,
      cancelUrl: cancelUrl,
      successUrl: successUrl,
      status: status,
      created: created,
      object: object,
      uiMode: uiMode,
      amountSubtotal: amountSubtotal,
      expiresAt: expiresAt,
      mode: mode,
      liveMode: livemode,
      clientReferenceId: clientReferenceId,
      customerEmail: customerEmail,
      paymentMethodCollection: paymentMethodCollection,
      adaptivePricing: adaptivePricing?.toEntity(),
      customerDetails: customerDetails?.toEntity(),
      paymentMethodOptions: paymentMethodOptions?.toEntity(),
      metadata: metadata?.toEntity(),
      totalDetails: totalDetails?.toEntity(),
      discounts: discounts,
    );
  }
}
