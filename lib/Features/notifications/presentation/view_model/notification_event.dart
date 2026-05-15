sealed class NotificationEvent {}

class GetNotificationsEvent extends NotificationEvent {}

class MarkNotificationReadEvent extends NotificationEvent {
  final String notificationId;
  MarkNotificationReadEvent({required this.notificationId});
}
