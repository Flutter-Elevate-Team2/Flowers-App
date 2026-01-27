import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/shipping_address_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_orders_dto.g.dart';

@JsonSerializable()
class Orders {
  @JsonKey(name: "shippingAddress")
  final ShippingAddressRequest? shippingAddress;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "orderItems")
  final List<CartItem>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "paidAt")
  final String? paidAt;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;

  Orders ({
    this.shippingAddress,
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return _$OrdersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersToJson(this);
  }
}
