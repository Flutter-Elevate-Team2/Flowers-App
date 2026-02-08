import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_data.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_view_model_test.mocks.dart';

@GenerateMocks([GetNotificationUseCase])
void main() {
  provideDummy<BaseResponse<NotificationData>>(
    SuccessResponse(data: NotificationData(notifications: [], unreadCount: 0)),
  );

  late MockGetNotificationUseCase mockGetNotificationUseCase;
  late NotificationViewModel viewModel;

  setUp(() {
    mockGetNotificationUseCase = MockGetNotificationUseCase();
    viewModel = NotificationViewModel(mockGetNotificationUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  test('initial state is correct', () {
    expect(viewModel.state.notificationsState, isNull);
    expect(viewModel.state.unreadCount, 0);
  });

  blocTest<NotificationViewModel, NotificationState>(
    'emits [loading, success] when GetNotificationsEvent is added and use case returns success',
    build: () {
      final notificationData = NotificationData(
        notifications: [NotificationEntity(title: 'Title', body: 'Body')],
        unreadCount: 1,
      );
      when(mockGetNotificationUseCase.call()).thenAnswer(
        (_) async => SuccessResponse<NotificationData>(data: notificationData),
      );
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(GetNotificationsEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      predicate<NotificationState>((state) {
        return state.notificationsState != null &&
            state.notificationsState!.isLoading == true;
      }),
      predicate<NotificationState>((state) {
        return state.notificationsState != null &&
            state.notificationsState!.isLoading == false &&
            state.notificationsState!.data!.length == 1 &&
            state.notificationsState!.data!.first.title == 'Title' &&
            state.unreadCount == 1;
      }),
    ],
  );

  blocTest<NotificationViewModel, NotificationState>(
    'emits [loading, error] when GetNotificationsEvent is added and use case returns error',
    build: () {
      when(mockGetNotificationUseCase.call()).thenAnswer(
        (_) async =>
            ErrorResponse<NotificationData>(errorMessage: 'Error message'),
      );
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(GetNotificationsEvent()),
    expect: () => [
      predicate<NotificationState>(
        (state) =>
            state.notificationsState != null &&
            state.notificationsState!.isLoading == true,
      ),
      predicate<NotificationState>(
        (state) =>
            state.notificationsState != null &&
            state.notificationsState!.isLoading == false &&
            state.notificationsState!.errorMessage == 'Error message',
      ),
    ],
  );
}
