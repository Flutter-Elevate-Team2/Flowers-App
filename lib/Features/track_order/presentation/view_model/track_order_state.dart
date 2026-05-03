import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class TrackOrderStatusState extends Equatable {
  final BaseState<OrderTrackingEntity>? orderState;
  final BaseState<void>? updateStatusState;
  final mapbox.Position? currentDriverPosition;
  final List<mapbox.Position>? routePoints;
  final bool showPickup;
  final Map<String, DateTime> statusHistory;
  final BaseState<bool>? sendSilentNotificationState;


  const TrackOrderStatusState({
    this.sendSilentNotificationState = const BaseState(),
    this.orderState = const BaseState(),
    this.updateStatusState = const BaseState(),
    this.currentDriverPosition,
    this.routePoints,
    this.showPickup = true,
    this.statusHistory = const {},
  });

  TrackOrderStatusState copyWith({
    BaseState<OrderTrackingEntity>? orderState,
    BaseState<void>? updateStatusState,
    mapbox.Position? currentDriverPosition,
    List<mapbox.Position>? routePoints,
    bool? showPickup,
    Map<String, DateTime>? statusHistory,
    BaseState<bool>? sendSilentNotificationState,
  }) {
    return TrackOrderStatusState(
      orderState: orderState ?? this.orderState,
      updateStatusState: updateStatusState ?? this.updateStatusState,
      currentDriverPosition:
      currentDriverPosition ?? this.currentDriverPosition,
      routePoints: routePoints ?? this.routePoints,
      showPickup: showPickup ?? this.showPickup,
      statusHistory: statusHistory ?? this.statusHistory,
      sendSilentNotificationState: sendSilentNotificationState ?? this.sendSilentNotificationState,
    );
  }

  @override
  List<Object?> get props => [
    orderState,
    updateStatusState,
    currentDriverPosition,
    routePoints,
    showPickup,
    statusHistory,
    sendSilentNotificationState,
  ];
}
