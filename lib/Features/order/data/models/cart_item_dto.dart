import 'package:flowers_app/Features/commerce/data/models/products_model/products_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: "product")
  final Products? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  CartItem ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return _$CartItemFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartItemToJson(this);
  }
}
