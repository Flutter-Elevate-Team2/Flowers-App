import 'package:equatable/equatable.dart'; // متنساش الإمبورت
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class NotificationState extends Equatable {
  final BaseState<List<NotificationEntity>>? notificationsState;
  final int unreadCount;

  const NotificationState({
    this.notificationsState, 
    this.unreadCount = 0,
  });

  NotificationState copyWith({
    BaseState<List<NotificationEntity>>? notificationsState,
    int? unreadCount,
  }) {
    return NotificationState(
      notificationsState: notificationsState ?? this.notificationsState,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
        notificationsState,
        unreadCount,
      ];
}