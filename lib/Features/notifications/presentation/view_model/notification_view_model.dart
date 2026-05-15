import 'dart:async'; // مهم جداً عشان الـ StreamSubscription
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/mark_notification_as_read_use_case.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationViewModel extends Cubit<NotificationState> {
  final GetNotificationUseCase _getNotificationUseCase;
  final MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;
  final AuthLocalDataSourceContract _authLocalDataSource;
  StreamSubscription? _notificationSubscription;

  NotificationViewModel(
    this._getNotificationUseCase,
    this._markNotificationAsReadUseCase,
    this._authLocalDataSource,
  ) : super(NotificationState());

  void doIntent(NotificationEvent event) {
    if (event is GetNotificationsEvent) {
      _getNotifications();
    } else if (event is MarkNotificationReadEvent) {
      _markNotificationAsRead(event.notificationId);
    }
  }

  void _getNotifications() async {
    emit(state.copyWith(notificationsState: BaseState(isLoading: true)));

    _notificationSubscription?.cancel();
    final String? userId = await _authLocalDataSource.getUserId();
    print("🔍 Current User ID: '$userId'");
    _notificationSubscription = _getNotificationUseCase
        .call(userId ?? '')
        .listen((response) {
          if (response is SuccessResponse<List<NotificationEntity>>) {
            final notifications = response.data;

            final unreadCount = notifications.where((n) => !n.isRead).length;

            emit(
              state.copyWith(
                notificationsState: BaseState(
                  isLoading: false,
                  data: notifications,
                ),
                unreadCount: unreadCount,
              ),
            );
          } else if (response is ErrorResponse<List<NotificationEntity>>) {
            emit(
              state.copyWith(
                notificationsState: BaseState(
                  isLoading: false,
                  errorMessage: response.errorMessage,
                ),
              ),
            );
          }
        });
  }

  // CRITICAL: No loading emit here.
  // The Firestore Stream subscription in _getNotifications() will fire
  // automatically when the document is updated, refreshing the UI silently.
  Future<void> _markNotificationAsRead(String notificationId) async {
    await _markNotificationAsReadUseCase.call(notificationId);
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}
