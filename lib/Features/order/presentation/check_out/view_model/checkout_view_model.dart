import 'dart:async';

import 'package:flowers_app/Features/auth/domain/use_cases/get_user_id_usecase.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/checkout/cash_order_checkout.dart';
import 'package:flowers_app/Features/order/domain/use_cases/checkout/credit_card_checkout.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_events.dart';
import 'package:flowers_app/Features/order/presentation/check_out/view_model/checkout_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/services/firebase_data_uploader_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckoutViewModel extends Cubit<CheckoutStates> {
  final CashOrderCheckout cashOrderCheckout;
  final CreditCardCheckout creditCardCheckout;
  final GetUserIdUseCase _getUserIdUseCase;

  CheckoutViewModel({
    required this.cashOrderCheckout,
    required this.creditCardCheckout,
    required GetUserIdUseCase getUserIdUseCase,
  }) : _getUserIdUseCase = getUserIdUseCase,
       super(const CheckoutStates());

  void doIntent(CheckoutEvent event) {
    if (event is CashPaymentEvent) {
      _cashCheckout(event.orderRequest);
    } else if (event is CreditCardPaymentEvent) {
      _creditCheckout(event.orderRequest);
    } else if (event is OnPaymentCancelEvent) {
      _handleCancel();
    }
  }

  Future<void> _cashCheckout(OrderRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await cashOrderCheckout.call(request);
      if (response is SuccessResponse<CashCheckoutResponseEntity>) {
        final order = response.data.order;
        if (order != null && order.id != null) {
          final userId = order.user ?? await _getUserIdUseCase.call();
          if (userId != null && userId.isNotEmpty) {
            await FirebaseDataUploaderService.uploadOrderData(
              userId,
              order.id!,
            );
          }
        }
        emit(state.copyWith(isLoading: false, cashResponse: response.data));
      } else if (response is ErrorResponse<CashCheckoutResponseEntity>) {
        emit(
          state.copyWith(isLoading: false, errorMessage: response.errorMessage),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _creditCheckout(OrderRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await creditCardCheckout.call(request);
      if (response is SuccessResponse<CreditCheckoutResponseEntity>) {
        final session = response.data.session;
        if (session != null && session.id != null) {
          final userId = await _getUserIdUseCase.call();
          if (userId != null && userId.isNotEmpty) {
            final orderId = session.clientReferenceId ?? session.id!;
            await FirebaseDataUploaderService.uploadOrderData(userId, orderId);
          }
        }
        final url = response.data.session?.url;
        if (url != null && url.isNotEmpty) {
          emit(state.copyWith(isLoading: false, redirectUrl: url));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: "Invalid payment session",
            ),
          );
        }
      } else if (response is ErrorResponse<CreditCheckoutResponseEntity>) {
        emit(
          state.copyWith(isLoading: false, errorMessage: response.errorMessage),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _handleCancel() {
    emit(state.copyWith(isPaymentCancelled: true, isLoading: false));
  }

  void resetPaymentState() {
    emit(
      state.copyWith(redirectUrl: null, cashResponse: null, isLoading: false),
    );
  }
}
