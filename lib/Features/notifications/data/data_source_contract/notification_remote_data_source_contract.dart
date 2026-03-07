import 'package:flowers_app/Features/notifications/data/models/notification_model.dart';

abstract class NotificationRemoteDataSourceContract {
  Stream<List<NotificationModel>> getNotifications(String userId);
  Future<void> markNotificationAsRead(String notificationId);
}
