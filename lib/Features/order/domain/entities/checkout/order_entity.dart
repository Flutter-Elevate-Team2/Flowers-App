import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';

class OrderEntity extends Equatable{
  final String? user;
  final List<CartItemEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;

  const OrderEntity({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });


  OrderEntity copyWith(String user,
      List<CartItemEntity> orderItems,
      int totalPrice,
      String paymentType,
      bool isPaid,
      bool isDelivered,
      String state,
      String id,
      String createdAt,
      String updatedAt,
      String orderNumber
      ){
    return OrderEntity(
      user: user,
      orderItems: orderItems,
        totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      id: id,

      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,

     );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,totalPrice,user,paymentType,isPaid,isDelivered,state,orderItems,createdAt,updatedAt,orderNumber];


}