import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:geolocator/geolocator.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class TrackOrderStatusState extends Equatable {
  final BaseState<OrderTrackingEntity>? orderState;
  final BaseState<void>? updateStatusState;
  final Position? currentDriverPosition;
  final List<mapbox.Position>? routePoints;
  final bool showPickup;

  const TrackOrderStatusState({
    this.orderState = const BaseState(),
    this.updateStatusState = const BaseState(),
    this.currentDriverPosition,
    this.routePoints,
    this.showPickup = true,
  });

  TrackOrderStatusState copyWith({
    BaseState<OrderTrackingEntity>? orderState,
    BaseState<void>? updateStatusState,
    Position? currentDriverPosition,
    List<mapbox.Position>? routePoints,
    bool? showPickup,
  }) {
    return TrackOrderStatusState(
      orderState: orderState ?? this.orderState,
      updateStatusState: updateStatusState ?? this.updateStatusState,
      currentDriverPosition:
      currentDriverPosition ?? this.currentDriverPosition,
      routePoints: routePoints ?? this.routePoints,
      showPickup: showPickup ?? this.showPickup,
    );
  }

  @override
  List<Object?> get props => [
    orderState,
    updateStatusState,
    currentDriverPosition,
    routePoints,
    showPickup,
  ];
}
