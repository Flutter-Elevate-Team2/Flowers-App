import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';

sealed class CheckoutEvent {}

class CashPaymentEvent extends CheckoutEvent {
  final OrderRequest orderRequest;
  CashPaymentEvent(this.orderRequest);
}

class CreditCardPaymentEvent extends CheckoutEvent {
  final OrderRequest orderRequest;
  CreditCardPaymentEvent(this.orderRequest);
}

class OnPaymentRedirectEvent extends CheckoutEvent {
  final String url;
  OnPaymentRedirectEvent(this.url);
}

class OnPaymentCancelEvent extends CheckoutEvent {}
