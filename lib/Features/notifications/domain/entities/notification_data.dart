import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';

class NotificationData {
  final List<NotificationEntity> notifications;
  final int unreadCount;

  NotificationData({required this.notifications, required this.unreadCount});
}
