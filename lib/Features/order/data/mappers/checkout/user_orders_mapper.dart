import 'package:flowers_app/Features/order/data/mappers/cart/cart_item_mapper.dart';
import 'package:flowers_app/Features/order/data/mappers/checkout/shipping_address_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';

extension OrdersMapper on Orders{
  OrdersEntity toEntity() {
    return OrdersEntity(
      id: id,
      user: user,
      totalPrice: totalPrice?.toDouble(),
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      orderNumber: orderNumber,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderItems: orderItems?.map((e) => e.toEntity()).toList(),
      shippingAddress: shippingAddress?.toEntity(),
    );
  }
}
