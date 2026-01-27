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
    CashCheckoutResponseEntity? cashResponse,
    CreditCheckoutResponseEntity? creditResponse,
    String? errorMessage,
    String? redirectUrl,
    bool? isPaymentCompleted,
    bool? isPaymentCancelled,
  }) {
    return CheckoutStates(
      isLoading: isLoading ?? this.isLoading,
      cashResponse: cashResponse ?? this.cashResponse,
      creditResponse: creditResponse ?? this.creditResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      isPaymentCompleted: isPaymentCompleted ?? this.isPaymentCompleted,
      isPaymentCancelled: isPaymentCancelled ?? this.isPaymentCancelled,
    );
  }

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
