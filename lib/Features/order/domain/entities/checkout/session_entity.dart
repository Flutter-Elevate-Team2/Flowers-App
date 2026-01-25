import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/adaptive_pricing_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/customer_details_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/payment_method_options.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/total_details_entity.dart';

class SessionEntity extends Equatable {
  final String? id;
  final String? object;
  final AdaptivePricingEntity? adaptivePricing;
  final int? amountSubtotal;
  final int? amountTotal;
  final String? cancelUrl;
  final String? clientReferenceId;
  final int? created;
  final String? currency;
  final CustomerDetailsEntity? customerDetails;
  final String? customerEmail;
  final List<int>? discounts;
  final int? expiresAt;
  final bool? liveMode;
  final MetadataEntity? metadata;
  final String? mode;
  final PaymentMethodOptionsEntity? paymentMethodOptions;
  final String? paymentMethodCollection;
  final String? paymentStatus;
  final String? status;
  final String? successUrl;
  final TotalDetailsEntity? totalDetails;
  final String? uiMode;
  final String? url;

  const SessionEntity({
    this.id,
    this.object,
    this.adaptivePricing,
    this.amountSubtotal,
    this.amountTotal,
    this.cancelUrl,
    this.clientReferenceId,
    this.created,
    this.currency,
    this.customerDetails,
    this.customerEmail,
    this.discounts,
    this.expiresAt,
    this.liveMode,
    this.metadata,
    this.mode,
    this.paymentMethodOptions,
    this.paymentMethodCollection,
    this.paymentStatus,
    this.status,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
  });

  SessionEntity copyWith(
    String user,
    List<CartItemEntity> orderItems,
    int totalPrice,
    String paymentType,
    bool isPaid,
    bool isDelivered,
    String state,
    String id,
    String createdAt,
    String updatedAt,
    String orderNumber,
  ) {
    return SessionEntity(
      id: id,
      object: object,
      adaptivePricing: adaptivePricing,
      amountSubtotal: amountSubtotal,
      amountTotal: amountTotal,
      cancelUrl: cancelUrl,
      clientReferenceId: clientReferenceId,
      created: created,
      currency: currency,
      customerDetails: customerDetails,
      customerEmail: customerEmail,
      discounts: discounts,
      expiresAt: expiresAt,
      liveMode: liveMode,
      metadata: metadata,
      mode: mode,
      paymentMethodOptions: paymentMethodOptions,
      paymentMethodCollection: paymentMethodCollection,
      paymentStatus: paymentStatus,
      status: status,
      successUrl: successUrl,
      totalDetails: totalDetails,
      uiMode: uiMode,
      url: url,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    object,
    adaptivePricing,
    amountSubtotal,
    amountTotal,
    cancelUrl,
    clientReferenceId,
    created,
    currency,
    customerDetails,
    customerEmail,
    discounts,
    expiresAt,
    liveMode,
    metadata,
    mode,
    paymentMethodOptions,
    paymentMethodCollection,
    paymentStatus,
    status,
    successUrl,
    totalDetails,
    uiMode,
    url,
  ];
}
