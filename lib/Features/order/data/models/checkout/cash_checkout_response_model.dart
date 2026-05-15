import 'package:flowers_app/Features/order/data/models/checkout/order_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_checkout_response_model.g.dart';

@JsonSerializable()
class CashCheckoutResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "order")
  final Order? order;

  CashCheckoutResponseModel ({
    this.message,
    this.order,
  });

  factory CashCheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CashCheckoutResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CashCheckoutResponseModelToJson(this);
  }
}






