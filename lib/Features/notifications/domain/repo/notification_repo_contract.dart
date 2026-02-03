import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class NotificationRepoContract {
  Future<BaseResponse<List<NotificationEntity>>> getNotifications();
}