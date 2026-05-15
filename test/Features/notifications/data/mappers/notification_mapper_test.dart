import 'package:flowers_app/Features/notifications/data/mappers/notification_mapper.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_model.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationModelMapper', () {
    test('toEntity maps all fields correctly', () {
      // Arrange
      final sentAt = DateTime(2026, 3, 1, 10, 30);
      final model = NotificationModel(
        id: 'notif_1',
        title: 'Order Shipped',
        body: 'Your order #123 has been shipped',
        isRead: false,
        orderId: 'order_123',
        status: 'shipped',
        receiverId: 'user_1',
        sentAt: sentAt,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<NotificationEntity>());
      expect(entity.id, 'notif_1');
      expect(entity.title, 'Order Shipped');
      expect(entity.body, 'Your order #123 has been shipped');
      expect(entity.isRead, false);
      expect(entity.orderId, 'order_123');
      expect(entity.status, 'shipped');
      expect(entity.sentAt, sentAt);
    });

    test('toEntity maps null optional fields correctly', () {
      // Arrange
      final sentAt = DateTime(2026, 3, 1);
      final model = NotificationModel(
        id: 'notif_2',
        title: 'Welcome',
        body: 'Welcome to our app!',
        isRead: true,
        sentAt: sentAt,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, 'notif_2');
      expect(entity.title, 'Welcome');
      expect(entity.body, 'Welcome to our app!');
      expect(entity.isRead, true);
      expect(entity.orderId, isNull);
      expect(entity.status, isNull);
      expect(entity.sentAt, sentAt);
    });

    test('toEntity preserves isRead default value (false)', () {
      // Arrange – isRead defaults to false in NotificationModel
      final model = NotificationModel(
        id: 'notif_3',
        title: 'New Promo',
        body: '50% off today!',
        sentAt: DateTime(2026, 1, 1),
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.isRead, false);
    });
  });
}
