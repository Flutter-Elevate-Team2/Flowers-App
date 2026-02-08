import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';

abstract class NotificationRemoteDataSourceContract {
  Future<NotificationResponse> getNotifications();
}