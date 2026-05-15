import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/get_notification_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notification_use_case_test.mocks.dart';

@GenerateMocks([NotificationRepoContract])
void main() {
  late GetNotificationUseCase useCase;
  late MockNotificationRepoContract mockRepo;

  setUp(() {
    mockRepo = MockNotificationRepoContract();
    useCase = GetNotificationUseCase(mockRepo);
  });

  group('GetNotificationUseCase', () {
    final now = DateTime(2026, 3, 1);

    test('delegates to repo.getNotifications with the given userId', () {
      // Arrange
      when(
        mockRepo.getNotifications('user_1'),
      ).thenAnswer((_) => const Stream.empty());

      // Act
      useCase.call('user_1');

      // Assert
      verify(mockRepo.getNotifications('user_1')).called(1);
    });

    test('emits SuccessResponse with notification list on success', () {
      // Arrange
      final entities = [
        NotificationEntity(
          id: '1',
          title: 'Order Shipped',
          body: 'Your order has been shipped',
          isRead: false,
          sentAt: now,
        ),
        NotificationEntity(
          id: '2',
          title: 'Welcome',
          body: 'Welcome to the app!',
          isRead: true,
          sentAt: now,
        ),
      ];
      final successResponse = SuccessResponse<List<NotificationEntity>>(
        data: entities,
      );

      when(
        mockRepo.getNotifications('user_1'),
      ).thenAnswer((_) => Stream.value(successResponse));

      // Act
      final stream = useCase.call('user_1');

      // Assert
      expect(
        stream,
        emitsInOrder([
          isA<SuccessResponse<List<NotificationEntity>>>().having(
            (r) => r.data.length,
            'notification count',
            2,
          ),
        ]),
      );
    });

    test('emits ErrorResponse when repo stream errors', () {
      // Arrange
      final errorResponse = ErrorResponse<List<NotificationEntity>>(
        errorMessage: 'Failed to fetch',
      );

      when(
        mockRepo.getNotifications('user_1'),
      ).thenAnswer((_) => Stream.value(errorResponse));

      // Act
      final stream = useCase.call('user_1');

      // Assert
      expect(
        stream,
        emitsInOrder([
          isA<ErrorResponse<List<NotificationEntity>>>().having(
            (r) => r.errorMessage,
            'error message',
            'Failed to fetch',
          ),
        ]),
      );
    });

    test('emits SuccessResponse with empty list when no notifications', () {
      // Arrange
      final successResponse = SuccessResponse<List<NotificationEntity>>(
        data: [],
      );

      when(
        mockRepo.getNotifications('user_1'),
      ).thenAnswer((_) => Stream.value(successResponse));

      // Act
      final stream = useCase.call('user_1');

      // Assert
      expect(
        stream,
        emitsInOrder([
          isA<SuccessResponse<List<NotificationEntity>>>().having(
            (r) => r.data.isEmpty,
            'empty list',
            true,
          ),
        ]),
      );
    });
  });
}
