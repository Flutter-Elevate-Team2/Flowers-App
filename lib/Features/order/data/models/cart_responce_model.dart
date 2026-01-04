import 'package:json_annotation/json_annotation.dart';

import 'cart_dto.dart';

part 'cart_responce_model.g.dart';

@JsonSerializable()
class CartResponceModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  CartResponceModel ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory CartResponceModel.fromJson(Map<String, dynamic> json) {
    return _$CartResponceModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartResponceModelToJson(this);
  }
}






