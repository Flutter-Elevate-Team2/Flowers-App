import 'package:flowers_app/Features/order/data/models/checkout/user_orders_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flowers_app/Features/order/data/models/checkout/orders_metadata_dto.dart';


part 'user_orders_response_model.g.dart';

@JsonSerializable()
class UserOrdersResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "orders")
  final List<Orders>? orders;

  UserOrdersResponseModel ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory UserOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    return _$UserOrdersResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserOrdersResponseModelToJson(this);
  }
}




