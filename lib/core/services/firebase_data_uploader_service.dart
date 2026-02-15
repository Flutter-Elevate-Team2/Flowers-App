import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/core/services/push_notification_service.dart';
import 'package:flutter/foundation.dart';

class FirebaseDataUploaderService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Uploads user data (userId and device token) to Firestore on app open.
  static Future<void> uploadUserDataOnOpen(String userId) async {
    try {
      final deviceToken = PushNotificationService.deviceToken;
      if (deviceToken == null) {
        if (kDebugMode) {
          print(
            'FirebaseDataUploaderService: Device token is null, skipping upload.',
          );
        }
        return;
      }

      await _firestore.collection('user_data').doc(userId).set({
        'userId': userId,
        'deviceToken': deviceToken,
        'lastOpened': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (kDebugMode) {
        print(
          'FirebaseDataUploaderService: User data uploaded successfully for $userId',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseDataUploaderService error (uploadUserDataOnOpen): $e');
      }
    }
  }

  /// Uploads order data (userId, orderId, and device token) to Firestore on order placement.
  static Future<void> uploadOrderData(String userId, String orderId) async {
    try {
      final deviceToken = PushNotificationService.deviceToken;
      if (deviceToken == null) {
        if (kDebugMode) {
          print(
            'FirebaseDataUploaderService: Device token is null, skipping order data upload.',
          );
        }
        return;
      }

      await _firestore.collection('order_data').doc(orderId).set({
        'userId': userId,
        'orderId': orderId,
        'deviceToken': deviceToken,
        'placedAt': FieldValue.serverTimestamp(),
      });

      if (kDebugMode) {
        print(
          'FirebaseDataUploaderService: Order data uploaded successfully for order $orderId',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseDataUploaderService error (uploadOrderData): $e');
      }
    }
  }
}
