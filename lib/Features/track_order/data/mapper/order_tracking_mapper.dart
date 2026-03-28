import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/store_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';

extension OrderTrackingMapper on OrderTrackingFirebaseModel {
  OrderTrackingEntity toEntity() {
    return OrderTrackingEntity(
      id: orderData['orderId']?.toString() ?? '',
      orderNumber: orderData['orderNumber']?.toString() ?? '',
      updatedAt: updatedAt ?? DateTime.now(),
      status: status,
      totalPrice: (orderData['totalPrice'] as num?)?.toDouble() ?? 0.0,
      paymentType: orderData['paymentType'] ?? '',
      shippingAddress: _formatShippingAddress(orderData['shippingAddress']),
      trackingLocation: TrackingLocationEntity(
        lat: (trackingLocation['lat'] as num?)?.toDouble() ?? 0.0,
        long: (trackingLocation['long'] as num?)?.toDouble() ?? 0.0,
      ),
      userLocationEntity: UserLocationEntity(
        lat: (orderData['shippingAddress']?['location']?['lat'] as num?)?.toDouble() ?? 30.0,
        long: (orderData['shippingAddress']?['location']?['long'] as num?)?.toDouble() ?? 31.0,
      ),
      driver: DriverEntity(
        id: driverData['driverId'] ?? '',
        name: driverData['driverName'] ?? '',
        phone: driverData['driverPhone'] ?? '',
        token: driverData['driverToken'] ?? '',
        vehicleNumber: driverData['vehicleNumber'] ?? '',
        vehicleImage: driverData['vehicleImage'] ?? '',
      ),
      store: StoreEntity(
        storeLat: (storeData['lat'] as num?)?.toDouble() ?? 29,
        storeLong: (storeData['long'] as num?)?.toDouble() ?? 31,
      ),
    );
  }

  String _formatShippingAddress(dynamic shipping) {
    if (shipping is Map) {
      final street = shipping['street']?.toString() ?? '';
      final city = shipping['city']?.toString() ?? '';
      if (street.isNotEmpty && city.isNotEmpty) {
        return '$street, $city';
      }
      return street.isNotEmpty ? street : city;
    }
    return shipping?.toString() ?? '';
  }
}
