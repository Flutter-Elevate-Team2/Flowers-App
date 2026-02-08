import 'package:flowers_app/Features/notifications/data/mappers/notification_mapper.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/metadata.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_model.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_data.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationMapper Tests', () {
    test(
      'toEntityList should map NotificationResponse to List<NotificationEntity> correctly',
      () {
        // Arrange
        final notificationModels = [
          NotificationModel(title: 'Welcome', body: 'Welcome to our app'),
          NotificationModel(
            title: 'New Offer',
            body: 'Check out our new offers',
          ),
          NotificationModel(
            title: 'Update Available',
            body: 'A new update is available for download',
          ),
        ];
        final notificationResponse = NotificationResponse(
          message: 'Success',
          notifications: notificationModels,
        );

        // Act
        final entityList = notificationResponse.toEntityList();

        // Assert
        expect(entityList, isA<List<NotificationEntity>>());
        expect(entityList.length, 3);

        expect(entityList[0].title, 'Welcome');
        expect(entityList[0].body, 'Welcome to our app');

        expect(entityList[1].title, 'New Offer');
        expect(entityList[1].body, 'Check out our new offers');

        expect(entityList[2].title, 'Update Available');
        expect(entityList[2].body, 'A new update is available for download');
      },
    );

    test('toEntityList should handle null notifications list', () {
      // Arrange
      final notificationResponse = NotificationResponse(
        message: 'Success',
        notifications: null,
      );

      // Act
      final entityList = notificationResponse.toEntityList();

      // Assert
      expect(entityList, isA<List<NotificationEntity>>());
      expect(entityList, isEmpty);
    });

    test('toEntityList should handle empty notifications list', () {
      // Arrange
      final notificationResponse = NotificationResponse(
        message: 'Success',
        notifications: [],
      );

      // Act
      final entityList = notificationResponse.toEntityList();

      // Assert
      expect(entityList, isA<List<NotificationEntity>>());
      expect(entityList, isEmpty);
    });

    test('getUnreadCount should return unread count from metadata', () {
      // Arrange
      final notificationResponse = NotificationResponse(
        message: 'Success',
        notifications: [],
        metadata: Metadata(unreadCount: 5),
      );

      // Act
      final unreadCount = notificationResponse.getUnreadCount();

      // Assert
      expect(unreadCount, 5);
    });

    test('getUnreadCount should return 0 when metadata is null', () {
      // Arrange
      final notificationResponse = NotificationResponse(
        message: 'Success',
        notifications: [],
        metadata: null,
      );

      // Act
      final unreadCount = notificationResponse.getUnreadCount();

      // Assert
      expect(unreadCount, 0);
    });

    test('getUnreadCount should return 0 when unreadCount is null', () {
      // Arrange
      final notificationResponse = NotificationResponse(
        message: 'Success',
        notifications: [],
        metadata: Metadata(unreadCount: null),
      );

      // Act
      final unreadCount = notificationResponse.getUnreadCount();

      // Assert
      expect(unreadCount, 0);
    });

    test('toNotificationData should map NotificationResponse correctly', () {
      // Arrange
      final notificationModels = [
        NotificationModel(title: 'Welcome', body: 'Welcome to our app'),
        NotificationModel(title: 'New Offer', body: 'Special discount'),
      ];
      final notificationResponse = NotificationResponse(
        message: 'Success',
        notifications: notificationModels,
        metadata: Metadata(unreadCount: 2),
      );

      // Act
      final notificationData = notificationResponse.toNotificationData();

      // Assert
      expect(notificationData, isA<NotificationData>());
      expect(notificationData.notifications.length, 2);
      expect(notificationData.unreadCount, 2);
      expect(notificationData.notifications[0].title, 'Welcome');
      expect(notificationData.notifications[1].title, 'New Offer');
    });

    test(
      'toNotificationData should handle null notifications and metadata',
      () {
        // Arrange
        final notificationResponse = NotificationResponse(
          message: 'Success',
          notifications: null,
          metadata: null,
        );

        // Act
        final notificationData = notificationResponse.toNotificationData();

        // Assert
        expect(notificationData, isA<NotificationData>());
        expect(notificationData.notifications, isEmpty);
        expect(notificationData.unreadCount, 0);
      },
    );
  });
}
