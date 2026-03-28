import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderTrackingFirebaseModel JSON Tests', () {
     final tDateTime = DateTime(2023, 10, 15, 10, 30);
    final tTimestamp = Timestamp.fromDate(tDateTime);

    final tUserData = {'userId': 'user_123', 'name': 'John Doe'};
    final tOrderData = {'orderId': 'ord_456', 'totalPrice': 150.0};
    final tDriverData = {'driverId': 'drv_789', 'name': 'Captain Jack'};
    final tTrackingLocation = {'lat': 30.0444, 'long': 31.2357};
    final tStoreData = {'storeId': 'str_001', 'name': 'Flower Shop'};
    final tOrderItems = [
      {'id': 'item_1', 'name': 'Red Rose', 'quantity': 5}
    ];

    final tFullJson = {
      'userData': tUserData,
      'orderData': tOrderData,
      'driverData': tDriverData,
      'trackingLocation': tTrackingLocation,
      'storeData': tStoreData,
      'orderItems': tOrderItems,
      'status': 'on_the_way',
      'updatedAt': tTimestamp, // Testing Firestore Timestamp
    };

    test('fromJson should return a valid model when all fields are provided', () {
      // Act
      final result = OrderTrackingFirebaseModel.fromJson(tFullJson);

      // Assert
      expect(result, isA<OrderTrackingFirebaseModel>());
      expect(result.status, 'on_the_way');
      expect(result.updatedAt, tDateTime);
      expect(result.userData['userId'], 'user_123');
      expect(result.orderData['orderId'], 'ord_456');
      expect(result.driverData['driverId'], 'drv_789');
      expect(result.trackingLocation['lat'], 30.0444);
      expect(result.storeData['name'], 'Flower Shop');
      expect(result.orderItems.length, 1);
      expect(result.orderItems.first['name'], 'Red Rose');
    });

    test('fromJson should handle different types of updatedAt (String, Timestamp, Null)', () {
      // 1. Test String date
      final jsonWithStringDate = {'updatedAt': '2023-10-15T10:30:00Z'};
      final model1 = OrderTrackingFirebaseModel.fromJson(jsonWithStringDate);
      expect(model1.updatedAt, isA<DateTime>());

      // 2. Test Timestamp
      final jsonWithTimestamp = {'updatedAt': tTimestamp};
      final model2 = OrderTrackingFirebaseModel.fromJson(jsonWithTimestamp);
      expect(model2.updatedAt, tDateTime);

      // 3. Test Null
      final jsonWithNullDate = {'updatedAt': null};
      final model3 = OrderTrackingFirebaseModel.fromJson(jsonWithNullDate);
      expect(model3.updatedAt, null);
    });

    test('fromJson should handle missing or null fields by providing default values', () {
      // Arrange
      final Map<String, dynamic> emptyJson = {};

      // Act
      final result = OrderTrackingFirebaseModel.fromJson(emptyJson);

      // Assert
      expect(result.userData, isA<Map<String, dynamic>>());
      expect(result.userData, isEmpty);

      expect(result.orderData, isEmpty);
      expect(result.driverData, isEmpty);
      expect(result.trackingLocation, isEmpty);
      expect(result.storeData, isEmpty);

      expect(result.orderItems, isA<List>());
      expect(result.orderItems, isEmpty);

      expect(result.status, 'accepted'); // Default value from your factory
      expect(result.updatedAt, null);
    });

    test('fromJson should handle malformed orderItems correctly', () {
      // Arrange
      final jsonWithNullItems = {
        'orderItems': null,
      };

      // Act
      final result = OrderTrackingFirebaseModel.fromJson(jsonWithNullItems);

      // Assert
      expect(result.orderItems, isA<List>());
      expect(result.orderItems, isEmpty);
    });

    test('fromJson should correctly map nested Map values', () {
      // Arrange
      final nestedJson = {
        'orderData': {
          'shippingAddress': {
            'street': 'Main St',
            'city': 'Cairo'
          }
        }
      };

      // Act
      final result = OrderTrackingFirebaseModel.fromJson(nestedJson);

      // Assert
      expect(result.orderData['shippingAddress']['street'], 'Main St');
      expect(result.orderData['shippingAddress']['city'], 'Cairo');
    });
  });
}