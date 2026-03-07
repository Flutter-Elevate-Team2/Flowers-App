// إضافة Extension لتحويل الموديل لـ Entity
import 'package:flowers_app/Features/notifications/data/models/notification_model.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';

extension NotificationModelMapper on NotificationModel {
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      isRead: isRead,
      orderId: orderId,
      status: status,
      sentAt: sentAt,
    );
  }
}