import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/shipping_address_entity.dart';

class OrdersEntity extends Equatable {
  final String? id;
  final String? user;
  final List<CartItemEntity>? orderItems;
  final ShippingAddressEntity? shippingAddress;
  final double? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? orderNumber;
  final String? createdAt;
  final String? updatedAt;

  const OrdersEntity({
    this.id,
    this.user,
    this.orderItems,
    this.shippingAddress,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.orderNumber,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    shippingAddress,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    orderNumber,
    createdAt,
    updatedAt,
  ];
}
