import 'package:flowers_app/Features/order/data/mappers/checkout/user_orders_mapper.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/data/mappers/checkout/metadata_mapper.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_response_model.dart';

extension OrdersResponseMapper on UserOrdersResponseModel {
  UserOrdersResponseEntity toEntity() {
    return UserOrdersResponseEntity(
      message: message,
        metadata:metadata?.toEntity(),
      orders: orders?.map((e) => e.toEntity()).toList(),
    );
  }
}
