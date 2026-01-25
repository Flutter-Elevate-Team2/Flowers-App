import 'package:flowers_app/Features/order/data/models/checkout/order_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flowers_app/Features/order/data/mappers/cart/cart_item_mapper.dart';

extension OrderMapper on Order {
  OrderEntity toEntity() {
    return OrderEntity(
      user: user,
      orderItems: orderItems?.map((e) => e.toEntity()).toList(),
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
}
