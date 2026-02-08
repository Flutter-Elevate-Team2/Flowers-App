import 'package:flowers_app/Features/order/data/models/cart/cart_dto.dart';
import 'package:json_annotation/json_annotation.dart';


part 'cart_response_model.g.dart';

@JsonSerializable()
class CartResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  CartResponseModel ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CartResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartResponseModelToJson(this);
  }
}




