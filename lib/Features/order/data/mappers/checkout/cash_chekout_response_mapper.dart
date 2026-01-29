import 'package:flowers_app/Features/order/data/mappers/checkout/order_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';

extension CashChekoutResponseMapper on CashCheckoutResponseModel {
  CashCheckoutResponseEntity toEntity() {
    return CashCheckoutResponseEntity(
      message: message,
      order: order?.toEntity(),
    );
  }
}
