import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';

extension NotificationResponseMapper on NotificationResponse {
  List<NotificationEntity> toEntityList() {
    return (notifications ?? [])
        .map((n) => NotificationEntity(
              title: n.title ?? '',
              body: n.body ?? '',
            ))
        .toList();
  }
}
