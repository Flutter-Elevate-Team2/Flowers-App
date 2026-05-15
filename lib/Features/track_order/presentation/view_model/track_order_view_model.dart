import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/Features/track_order/data/mapper/order_tracking_mapper.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_directions_use_case.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/send_silent_notification_use_case.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class OrderStatusViewModel extends Cubit<TrackOrderStatusState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final SendSilentNotificationUseCase _sendSilentNotificationUseCase;
  final GetDirectionsUseCase _getDirectionsUseCase;

  OrderStatusViewModel(
    this._getOrderDetailsUseCase,
    this._sendSilentNotificationUseCase,
    this._getDirectionsUseCase,
  ) : super(const TrackOrderStatusState());

  String? _currentOrderId;
  Map<String, DateTime> _statusHistory = {};
  StreamSubscription<OrderTrackingFirebaseModel>? _orderSub;

  // ✅ متغيرات حفظ الحالة لمنع الريكويستات العشوائية
  mapbox.Position? _lastCalculatedDriverPos;

  Future<void> doIntent(
    BuildContext context,
    TrackOrderStatusEvent event,
  ) async {
    switch (event) {
      case FetchOrderDetailsEvent():
        await _fetchOrderDetails(event.orderId);
        break;
      case SendSilentNotificationEvent():
        await _sendSilentNotification(event.orderId, event.driverToken);
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
            orderState: const BaseState(
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
      decoded.forEach((k, v) => history[k] = DateTime.parse(v));
    }

    _statusHistory = history;
    return history;
  }

  Stream<OrderTrackingFirebaseModel> watchOrder(String orderId) {
    return FirebaseFirestore.instance
        .collection('active_orders')
        .doc(orderId)
        .snapshots()
        .where((doc) => doc.exists && doc.data() != null)
        .map((doc) => OrderTrackingFirebaseModel.fromJson(doc.data()!));
  }

  void watchOrderChanges(String orderId) {
    _currentOrderId = orderId;
    _orderSub?.cancel();

    _orderSub = watchOrder(orderId).listen((order) async {
      await _saveStatus(
        order.status.isEmpty ? "unknown" : order.status,
        order.updatedAt ?? DateTime.now(),
      );

      final orderEntity = order.toEntity();
      final driverPos = mapbox.Position(
        orderEntity.trackingLocation.long,
        orderEntity.trackingLocation.lat,
      );

      // ✅ تحديد المسار الكامل دائماً (سائق -> متجر -> عميل)
      final waypoints = [
        driverPos,
        mapbox.Position(
          orderEntity.store.storeLong,
          orderEntity.store.storeLat,
        ),
        mapbox.Position(
          orderEntity.userLocationEntity.long,
          orderEntity.userLocationEntity.lat,
        ),
      ];

      // ✅ فلترة الريكويستات: هل السائق تحرك فعلياً؟
      bool shouldFetchRoute = false;

      if (_lastCalculatedDriverPos == null ||
          _lastCalculatedDriverPos!.lat != driverPos.lat ||
          _lastCalculatedDriverPos!.lng != driverPos.lng) {
        shouldFetchRoute = true;
      }

      if (shouldFetchRoute) {
        try {
          // نطلب المسار الجديد فقط لو السائق غير مكانه
          final routePoints = await _getDirectionsUseCase.call(waypoints);

          _lastCalculatedDriverPos = driverPos; // تحديث آخر مكان تم الحساب عنده

          emit(
            state.copyWith(
              orderState: BaseState(isLoading: false, data: orderEntity),
              routePoints: routePoints,
              currentDriverPosition: driverPos,
              statusHistory: _statusHistory,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              orderState: BaseState(isLoading: false, data: orderEntity),
              statusHistory: _statusHistory,
            ),
          );
          debugPrint("Directions Error: $e");
        }
      } else {
        // ✅ السائق لم يتحرك؟ نحدث الـ UI فقط ببيانات الـ Firebase بدون Mapbox API
        emit(
          state.copyWith(
            orderState: BaseState(isLoading: false, data: orderEntity),
            currentDriverPosition: driverPos,
            statusHistory: _statusHistory,
          ),
        );
      }
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

    if (response is SuccessResponse<bool>) {
      emit(
        state.copyWith(
          sendSilentNotificationState: const BaseState(
            isLoading: false,
            data: true,
          ),
        ),
      );
    } else if (response is ErrorResponse<bool>) {
      emit(
        state.copyWith(
          sendSilentNotificationState: BaseState(
            isLoading: false,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _orderSub?.cancel();
    return super.close();
  }
}
