import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_model.dart';
import 'package:flowers_app/Features/notifications/data/repo/notification_repo_imple.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_repo_imple_test.mocks.dart';

@GenerateMocks([NotificationRemoteDataSourceContract])
void main() {
  late NotificationRepoImple repo;
  late MockNotificationRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockNotificationRemoteDataSourceContract();
    repo = NotificationRepoImple(mockRemoteDataSource);
  });

  group('getNotifications', () {
    final now = DateTime(2026, 3, 1);

    test('emits SuccessResponse with mapped entities on success', () {
      // Arrange
      final models = [
        NotificationModel(
          id: '1',
          title: 'Title 1',
          body: 'Body 1',
          isRead: false,
          sentAt: now,
        ),
        NotificationModel(
          id: '2',
          title: 'Title 2',
          body: 'Body 2',
          isRead: true,
          sentAt: now,
        ),
      ];

      when(
        mockRemoteDataSource.getNotifications('user_1'),
      ).thenAnswer((_) => Stream.value(models));

      // Act
      final stream = repo.getNotifications('user_1');

      // Assert
      expect(
        stream,
        emitsInOrder([
          isA<SuccessResponse<List<NotificationEntity>>>().having(
            (r) => r.data.length,
            'entity count',
            2,
          ),
        ]),
      );
    });

    test('emits SuccessResponse with empty list when no notifications', () {
      // Arrange
      when(
        mockRemoteDataSource.getNotifications('user_1'),
      ).thenAnswer((_) => Stream.value([]));

      // Act
      final stream = repo.getNotifications('user_1');

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

    test('handles error from remote data source gracefully', () {
      // Arrange
      when(
        mockRemoteDataSource.getNotifications('user_1'),
      ).thenAnswer((_) => Stream.error(Exception('Network error')));

      // Act
      final stream = repo.getNotifications('user_1');

      // Assert – Stream.handleError swallows the error and the stream closes.
      // No data event is emitted; the stream simply completes.
      expect(stream, emitsDone);
    });
  });

  group('markNotificationAsRead', () {
    test('returns SuccessResponse on success', () async {
      // Arrange
      when(
        mockRemoteDataSource.markNotificationAsRead('notif_1'),
      ).thenAnswer((_) async {});

      // Act
      final result = await repo.markNotificationAsRead('notif_1');

      // Assert
      expect(result, isA<SuccessResponse<void>>());
      verify(mockRemoteDataSource.markNotificationAsRead('notif_1')).called(1);
    });

    test('returns ErrorResponse when remote throws', () async {
      // Arrange
      when(
        mockRemoteDataSource.markNotificationAsRead('notif_1'),
      ).thenThrow(Exception('Firestore error'));

      // Act
      final result = await repo.markNotificationAsRead('notif_1');

      // Assert
      expect(result, isA<ErrorResponse<void>>());
      verify(mockRemoteDataSource.markNotificationAsRead('notif_1')).called(1);
    });
  });
}
