import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
   final tDate = DateTime(2026, 3, 1, 12, 0, 0);
  final tTimestamp = Timestamp.fromDate(tDate);

  group('NotificationModel', () {
    test('should return a valid model from JSON with Firebase Timestamp', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'body': 'Test Body',
        'title': 'Test Title',
        'isRead': false,
        'sentAt': tTimestamp,
      };

      // Act
      final result = NotificationModel.fromJson(jsonMap);

      // Assert
      expect(result.id, '1');
      expect(result.sentAt, tDate);
    });

    test('should merge metadata fields into the main model during fromJson', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'body': 'Test Body',
        'title': 'Test Title',
        'sentAt': tTimestamp,
        'metadata': {
          'orderId': 'order_123',
          'status': 'shipped',
        },
      };

      // Act
      final result = NotificationModel.fromJson(jsonMap);

      // Assert
      expect(result.orderId, 'order_123');
      expect(result.status, 'shipped');
    });

    test('should convert DateTime to Timestamp when calling toJson', () {
      // Arrange
      final model = NotificationModel(
        id: '1',
        body: 'Body',
        title: 'Title',
        sentAt: tDate,
      );

      // Act
      final result = model.toJson();

      // Assert
      expect(result['sentAt'], isA<Timestamp>());
      expect((result['sentAt'] as Timestamp).toDate(), tDate);
    });

    test('should handle String date in fromJson via TimestampConverter', () {
      // Arrange
      const dateString = "2026-03-01T12:00:00.000";
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'body': 'Body',
        'title': 'Title',
        'sentAt': dateString,
      };

      // Act
      final result = NotificationModel.fromJson(jsonMap);

      // Assert
      expect(result.sentAt, DateTime.parse(dateString));
    });
  });
}