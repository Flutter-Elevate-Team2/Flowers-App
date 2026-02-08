import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';

class CashCheckoutResponseEntity extends Equatable {
  final String? message;
  final OrderEntity? order;


  const CashCheckoutResponseEntity({ this.message, this.order});

  CashCheckoutResponseEntity copyWith(
      String message,
      OrderEntity order
      ) {
    return CashCheckoutResponseEntity(
      message: message,order: order,
    );
  }

  @override
  List<Object?> get props => [message, order];
}
