import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';

class UserOrdersResponseEntity extends Equatable {
  final String? message;
  final OrdersMetadata? metadata;
  final List<OrdersEntity>? orders;

  const UserOrdersResponseEntity({
    this.message,
    this.metadata,
    this.orders,
  });

  @override
  List<Object?> get props => [message, metadata, orders];
}
