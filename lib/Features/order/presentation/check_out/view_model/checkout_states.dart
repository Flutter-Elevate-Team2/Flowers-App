import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';

class CheckoutStates extends Equatable {
  final bool isLoading;
  final CashCheckoutResponseEntity? cashResponse;
  final CreditCheckoutResponseEntity? creditResponse;
  final String? errorMessage;
  final String? redirectUrl;
  final bool isPaymentCompleted;
  final bool isPaymentCancelled;

  const CheckoutStates({
    this.isLoading = false,
    this.cashResponse,
    this.creditResponse,
    this.errorMessage,
    this.redirectUrl,
    this.isPaymentCompleted = false,
    this.isPaymentCancelled = false,
  });

  CheckoutStates copyWith({
    bool? isLoading,
    Object? cashResponse = _sentinel,
    Object? creditResponse = _sentinel,
    Object? errorMessage = _sentinel,
    Object? redirectUrl = _sentinel,
    bool? isPaymentCompleted,
    bool? isPaymentCancelled,
  }) {
    return CheckoutStates(
      isLoading: isLoading ?? this.isLoading,
      cashResponse: cashResponse == _sentinel
          ? this.cashResponse
          : (cashResponse as CashCheckoutResponseEntity?),
      creditResponse: creditResponse == _sentinel
          ? this.creditResponse
          : (creditResponse as CreditCheckoutResponseEntity?),
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : (errorMessage as String?),
      redirectUrl: redirectUrl == _sentinel
          ? this.redirectUrl
          : (redirectUrl as String?),
      isPaymentCompleted: isPaymentCompleted ?? this.isPaymentCompleted,
      isPaymentCancelled: isPaymentCancelled ?? this.isPaymentCancelled,
    );
  }

  static const _sentinel = Object();
  @override
  List<Object?> get props => [
    isLoading,
    cashResponse,
    creditResponse,
    errorMessage,
    redirectUrl,
    isPaymentCompleted,
    isPaymentCancelled,
  ];
}
