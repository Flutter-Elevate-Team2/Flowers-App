import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_item_entity.dart';

class CartEntity extends Equatable{
  final String? user;
  final List<CartItemEntity>? cartItems;
  final String? id;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;
  final int deliveryFee;


  const CartEntity({
    this.user,
    this.cartItems,
    this.id,
    this.appliedCoupons,
    this.totalPrice,
    this.deliveryFee = 10,
  });

  int get finalPrice {
    return (totalPrice ?? 0) + deliveryFee;
  }

  CartEntity copyWith(String user ,List<CartItemEntity> cartItems,
      String id,
      List<dynamic> appliedCoupons,
      int totalPrice,
      int deliveryFee
      ){
    return CartEntity(id: id,
    totalPrice: totalPrice,
    user: user,
    deliveryFee: deliveryFee,
    appliedCoupons: appliedCoupons,
    cartItems: cartItems);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,totalPrice,user,appliedCoupons,cartItems , deliveryFee];


}