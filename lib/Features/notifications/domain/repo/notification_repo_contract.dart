import 'package:flowers_app/Features/notifications/domain/entities/notification_data.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class NotificationRepoContract {
  Future<BaseResponse<NotificationData>> getNotifications();
}
