import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/mark_notification_as_read_use_case.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_event.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_state.dart';
import 'package:flowers_app/Features/notifications/presentation/view_model/notification_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_view_model_test.mocks.dart';

@GenerateMocks([
  GetNotificationUseCase,
  MarkNotificationAsReadUseCase,
  AuthLocalDataSourceContract,
])
void main() {
  provideDummy<BaseResponse<void>>(SuccessResponse<void>(data: null));

  late MockGetNotificationUseCase mockGetNotificationUseCase;
  late MockMarkNotificationAsReadUseCase mockMarkNotificationAsReadUseCase;
  late MockAuthLocalDataSourceContract mockAuthLocalDataSource;
  late NotificationViewModel viewModel;

  final now = DateTime(2026, 3, 1);

  setUp(() {
    mockGetNotificationUseCase = MockGetNotificationUseCase();
    mockMarkNotificationAsReadUseCase = MockMarkNotificationAsReadUseCase();
    mockAuthLocalDataSource = MockAuthLocalDataSourceContract();
    viewModel = NotificationViewModel(
      mockGetNotificationUseCase,
      mockMarkNotificationAsReadUseCase,
      mockAuthLocalDataSource,
    );
  });

  tearDown(() {
    viewModel.close();
  });

  // ── Initial State ──────────────────────────────────────────────────────────
  test('initial state has null notificationsState and unreadCount 0', () {
    expect(viewModel.state.notificationsState, isNull);
    expect(viewModel.state.unreadCount, 0);
  });

  // ── GetNotificationsEvent → Loading ────────────────────────────────────────
  blocTest<NotificationViewModel, NotificationState>(
    'emits loading state when GetNotificationsEvent is dispatched',
    build: () {
      when(
        mockAuthLocalDataSource.getUserId(),
      ).thenAnswer((_) async => 'user_1');
      when(
        mockGetNotificationUseCase.call('user_1'),
      ).thenAnswer((_) => const Stream.empty());
      return viewModel;
    },
    act: (vm) => vm.doIntent(GetNotificationsEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      predicate<NotificationState>(
        (s) =>
            s.notificationsState != null &&
            s.notificationsState!.isLoading == true,
      ),
    ],
  );

  // ── GetNotificationsEvent → Success ────────────────────────────────────────
  blocTest<NotificationViewModel, NotificationState>(
    'emits success state with notifications and correct unreadCount',
    build: () {
      final entities = [
        NotificationEntity(
          id: '1',
          title: 'Title 1',
          body: 'Body 1',
          isRead: false,
          sentAt: now,
        ),
        NotificationEntity(
          id: '2',
          title: 'Title 2',
          body: 'Body 2',
          isRead: true,
          sentAt: now,
        ),
        NotificationEntity(
          id: '3',
          title: 'Title 3',
          body: 'Body 3',
          isRead: false,
          sentAt: now,
        ),
      ];

      when(
        mockAuthLocalDataSource.getUserId(),
      ).thenAnswer((_) async => 'user_1');
      when(mockGetNotificationUseCase.call('user_1')).thenAnswer(
        (_) => Stream.value(
          SuccessResponse<List<NotificationEntity>>(data: entities),
        ),
      );
      return viewModel;
    },
    act: (vm) => vm.doIntent(GetNotificationsEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      // First: loading
      predicate<NotificationState>(
        (s) => s.notificationsState!.isLoading == true,
      ),
      // Second: success with data
      predicate<NotificationState>(
        (s) =>
            s.notificationsState!.isLoading == false &&
            s.notificationsState!.data != null &&
            s.notificationsState!.data!.length == 3 &&
            s.unreadCount == 2,
      ),
    ],
  );

  // ── GetNotificationsEvent → Error ──────────────────────────────────────────
  blocTest<NotificationViewModel, NotificationState>(
    'emits error state when stream returns ErrorResponse',
    build: () {
      when(
        mockAuthLocalDataSource.getUserId(),
      ).thenAnswer((_) async => 'user_1');
      when(mockGetNotificationUseCase.call('user_1')).thenAnswer(
        (_) => Stream.value(
          ErrorResponse<List<NotificationEntity>>(
            errorMessage: 'Network error',
          ),
        ),
      );
      return viewModel;
    },
    act: (vm) => vm.doIntent(GetNotificationsEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      // First: loading
      predicate<NotificationState>(
        (s) => s.notificationsState!.isLoading == true,
      ),
      // Second: error
      predicate<NotificationState>(
        (s) =>
            s.notificationsState!.isLoading == false &&
            s.notificationsState!.errorMessage == 'Network error',
      ),
    ],
  );

  // ── GetNotificationsEvent with null userId ─────────────────────────────────
  blocTest<NotificationViewModel, NotificationState>(
    'uses empty string when userId is null',
    build: () {
      when(mockAuthLocalDataSource.getUserId()).thenAnswer((_) async => null);
      when(
        mockGetNotificationUseCase.call(''),
      ).thenAnswer((_) => const Stream.empty());
      return viewModel;
    },
    act: (vm) => vm.doIntent(GetNotificationsEvent()),
    wait: const Duration(milliseconds: 100),
    verify: (_) {
      verify(mockGetNotificationUseCase.call('')).called(1);
    },
  );

  // ── MarkNotificationReadEvent ──────────────────────────────────────────────
  blocTest<NotificationViewModel, NotificationState>(
    'calls markNotificationAsRead use case',
    build: () {
      when(
        mockMarkNotificationAsReadUseCase.call('notif_1'),
      ).thenAnswer((_) async => SuccessResponse<void>(data: null));
      return viewModel;
    },
    act: (vm) =>
        vm.doIntent(MarkNotificationReadEvent(notificationId: 'notif_1')),
    wait: const Duration(milliseconds: 100),
    verify: (_) {
      verify(mockMarkNotificationAsReadUseCase.call('notif_1')).called(1);
    },
  );
}
