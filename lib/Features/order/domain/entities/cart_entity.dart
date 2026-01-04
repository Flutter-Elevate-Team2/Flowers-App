import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_item_entity.dart';

class CartEntity extends Equatable{
  final String? user;
  final List<CartItemEntity>? cartItems;
  final String? id;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;


  const CartEntity({
    this.user,
    this.cartItems,
    this.id,
    this.appliedCoupons,
    this.totalPrice,

  });
  CartEntity copyWith(String user ,List<CartItemEntity> cartItems,
      String id,
      List<dynamic> appliedCoupons,
      int totalPrice


      ){
    return CartEntity(id: id,
    totalPrice: totalPrice,
    user: user,
    appliedCoupons: appliedCoupons,
    cartItems: cartItems);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,totalPrice,user,appliedCoupons,cartItems];


}