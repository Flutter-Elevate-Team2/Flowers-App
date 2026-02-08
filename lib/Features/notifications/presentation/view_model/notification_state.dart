import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class NotificationState {
  final BaseState<List<NotificationEntity>>? notificationsState;
  final int unreadCount;

  NotificationState({this.notificationsState, this.unreadCount = 0});

  NotificationState copyWith({
    BaseState<List<NotificationEntity>>? notificationsState,
    int? unreadCount,
  }) {
    return NotificationState(
      notificationsState: notificationsState ?? this.notificationsState,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
