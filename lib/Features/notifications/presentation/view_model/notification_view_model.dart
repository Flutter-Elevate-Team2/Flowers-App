import 'package:flowers_app/Features/notifications/domain/entities/notification_data.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/services/push_notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationViewModel extends Cubit<NotificationState> {
  final GetNotificationUseCase _getNotificationUseCase;

  NotificationViewModel(this._getNotificationUseCase)
    : super(NotificationState()) {
    PushNotificationService.onNotificationReceived.listen((_) {
      doIntent(GetNotificationsEvent());
    });
  }

  void doIntent(NotificationEvent event) {
    if (event is GetNotificationsEvent) {
      _getNotification();
    }
  }

  Future<void> _getNotification() async {
    emit(state.copyWith(notificationsState: BaseState(isLoading: true)));
    final response = await _getNotificationUseCase.call();
    switch (response) {
      case SuccessResponse<NotificationData>():
        emit(
          state.copyWith(
            notificationsState: BaseState(
              isLoading: false,
              data: response.data.notifications,
            ),
            unreadCount: response.data.unreadCount,
          ),
        );
        break;
      case ErrorResponse<NotificationData>():
        emit(
          state.copyWith(
            notificationsState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
