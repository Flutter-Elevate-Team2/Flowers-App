import 'package:flowers_app/Features/order/data/mappers/checkout/session_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';

extension CreditChekoutResponseMapper on CreditCheckoutResponseModel {
  CreditCheckoutResponseEntity toEntity() {
    return CreditCheckoutResponseEntity(
      message: message,
      session: session?.toEntity(),
    );
  }
}
