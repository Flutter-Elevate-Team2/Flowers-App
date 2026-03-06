import 'dart:async';
import 'dart:convert';
import 'package:flowers_app/Features/track_order/data/mapper/order_tracking_mapper.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/send_silent_notification_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@injectable
class OrderStatusViewModel extends Cubit<TrackOrderStatusState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final SendSilentNotificationUseCase _sendSilentNotificationUseCase;

  OrderStatusViewModel(
    this._getOrderDetailsUseCase,
    this._sendSilentNotificationUseCase,
  ) : super(const TrackOrderStatusState());

  String? _currentOrderId;

  Map<String, DateTime> _statusHistory = {};

  void doIntent(BuildContext context, TrackOrderStatusEvent event) {
    switch (event) {
      case FetchOrderDetailsEvent():
        _fetchOrderDetails(event.orderId);
        break;
      case SendSilentNotificationEvent():
        _sendSilentNotification(event.orderId, event.driverToken);
        break;
    }
  }

  Future<void> _fetchOrderDetails(String orderId) async {
    _currentOrderId = orderId;
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
        await _saveStatus(response.status, response.updatedAt);
        final history = await getStatusHistory(orderId);

        emit(
          state.copyWith(
            orderState: BaseState(isLoading: false, data: response),
            statusHistory: history,
          ),
        );
        watchOrderChanges(orderId);
      } else {
        emit(
          state.copyWith(
            orderState: BaseState(
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

  Future<void> _saveStatus(String status, DateTime updatedAt) async {
    if (_currentOrderId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = "order_status_$_currentOrderId";
    final existing = prefs.getString(key);
    final Map<String, dynamic> map = existing != null
        ? jsonDecode(existing)
        : {};

    if (!map.containsKey(status)) {
      map[status] = updatedAt.toIso8601String();
      //   map[status] = DateTime.now().toIso8601String();
      await prefs.setString(key, jsonEncode(map));
    }

    _statusHistory = map.map((k, v) => MapEntry(k, DateTime.parse(v)));
    emit(state.copyWith(statusHistory: _statusHistory));
  }

  Future<Map<String, DateTime>> getStatusHistory(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "order_status_$orderId";
    final existing = prefs.getString(key);
    Map<String, DateTime> history = {};

    if (existing != null) {
      final decoded = jsonDecode(existing) as Map<String, dynamic>;
      decoded.forEach((k, v) {
        history[k] = DateTime.parse(v);
      });
    }

    _statusHistory = history;
    return history;
  }

  Stream<OrderTrackingFirebaseModel> watchOrder(String orderId) {
    return FirebaseFirestore.instance
        .collection('active_orders')
        .doc(orderId)
        .snapshots()
        .map((doc) => OrderTrackingFirebaseModel.fromJson(doc.data()!));
  }

  StreamSubscription<OrderTrackingFirebaseModel>? _orderSub;

  void watchOrderChanges(String orderId) {
    _currentOrderId = orderId;

    _orderSub?.cancel();

    _orderSub = watchOrder(orderId).listen((order) async {
      await _saveStatus(order.status, order.updatedAt ?? DateTime.now());

      emit(
        state.copyWith(
          orderState: BaseState(isLoading: false, data: order.toEntity()),
          statusHistory: _statusHistory,
        ),
      );
    });
  }

  Future<void> _sendSilentNotification(
    String orderId,
    String driverToken,
  ) async {
    emit(
      state.copyWith(
        sendSilentNotificationState: const BaseState(isLoading: true),
      ),
    );

    final response = await _sendSilentNotificationUseCase(
      orderId: orderId,
      driverToken: driverToken,
    );

    switch (response) {
      case SuccessResponse<bool>():
        emit(
          state.copyWith(
            sendSilentNotificationState: const BaseState(
              isLoading: false,
              data: true,
            ),
          ),
        );
        break;
      case ErrorResponse<bool>():
        emit(
          state.copyWith(
            sendSilentNotificationState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _orderSub?.cancel();
    return super.close();
  }
}
