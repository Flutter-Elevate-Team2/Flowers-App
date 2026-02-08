import 'package:flowers_app/Features/order/data/mappers/cart_item_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_entity.dart';

extension CartMapper on Cart {
  CartEntity toEntity() {
    return CartEntity(
      id: id,
      cartItems: cartItems?.map((e) => e.toEntity()).toList(),
      user: user,
      totalPrice: totalPrice,
      appliedCoupons: appliedCoupons
    );
  }
}
