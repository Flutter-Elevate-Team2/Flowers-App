import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_request_dto.g.dart';

@JsonSerializable()
class OrderRequest {
  @JsonKey(name: 'shippingAddress')
  final ShippingAddressRequest shippingAddress;

  OrderRequest({required this.shippingAddress});

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderRequestToJson(this);
}
