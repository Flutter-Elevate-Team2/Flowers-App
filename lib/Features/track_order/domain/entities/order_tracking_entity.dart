import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';

class OrderTrackingEntity {
  final String id;
  final String orderNumber;
  final DateTime updatedAt;
  final String status;
  final double totalPrice;
  final String paymentType;
  final String shippingAddress;
  final TrackingLocationEntity trackingLocation;
  final UserLocationEntity userLocationEntity;
  final DriverEntity ? driver;
  final Map<String, DateTime>? statusHistory;

  OrderTrackingEntity({
    required this.id,
    required this.orderNumber,
    required this.updatedAt,
    required this.status,
    required this.totalPrice,
    required this.paymentType,
    required this.shippingAddress,
    required this.trackingLocation,
    required this.userLocationEntity,
    required this.driver,
    this.statusHistory,
  });
}
