import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/order_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/session_entity.dart';

class CreditCheckoutResponseEntity extends Equatable {
  final String? message;
  final SessionEntity? session;


  const CreditCheckoutResponseEntity({ this.message, this.session});

  CreditCheckoutResponseEntity copyWith(
      String message,
      OrderEntity order
      ) {
    return CreditCheckoutResponseEntity(
      message: message,session: session,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [message, session];
}
