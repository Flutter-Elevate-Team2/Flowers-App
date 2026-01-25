import 'package:flowers_app/Features/order/data/models/checkout/credit/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_checkout_response_model.g.dart';

@JsonSerializable()
class CreditCheckoutResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "session")
  final Session? session;

  CreditCheckoutResponseModel ({
    this.message,
    this.session,
  });

  factory CreditCheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CreditCheckoutResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreditCheckoutResponseModelToJson(this);
  }
}


