import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:injectable/injectable.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_order_details_use_case.dart';
 import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

@injectable
class OrderStatusViewModel extends Cubit<TrackOrderStatusState> {
   final GetOrderDetailsUseCase _getOrderDetailsUseCase;

  OrderStatusViewModel(
     this._getOrderDetailsUseCase,
    ) : super(const TrackOrderStatusState());

  void doIntent(BuildContext context, TrackOrderStatusEvent event) {
    switch (event) {
      case FetchOrderDetailsEvent():
        _fetchOrderDetails(event.orderId);
        break;
    }
  }

  Future<void> _fetchOrderDetails(String orderId) async {
    if (state.orderState?.data == null) {
      emit(state.copyWith(orderState: const BaseState(isLoading: true)));
    } else {
      emit(
        state.copyWith(orderState: state.orderState?.copyWith(isLoading: true)),
      );
    }
    try {
      final response = await _getOrderDetailsUseCase(orderId);

      if (response != null) {
        emit(
          state.copyWith(
            orderState: BaseState(isLoading: false, data: response),
          ),
        );
      } else {
        emit(
          state.copyWith(
            orderState:   BaseState(
              isLoading: false,
              errorMessage: "Order Not Found",
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          orderState: BaseState(isLoading: false, errorMessage: e.toString()),
        ),
      );
    }
  }

}
