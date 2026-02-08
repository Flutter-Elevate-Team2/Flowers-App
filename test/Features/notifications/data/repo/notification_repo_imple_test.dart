import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/metadata.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_model.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/Features/notifications/data/repo/notification_repo_imple.dart';
import 'package:flowers_app/Features/notifications/domain/entities/notification_data.dart';
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

  group('NotificationRepoImple Tests', () {
    group('getNotifications', () {
      test(
        'should return SuccessResponse with NotificationData when remote call succeeds',
        () async {
          // Arrange
          final notificationModels = [
            NotificationModel(title: 'Welcome', body: 'Welcome to our app'),
            NotificationModel(
              title: 'New Offer',
              body: 'Check out our new offers',
            ),
          ];
          final notificationResponse = NotificationResponse(
            message: 'Success',
            notifications: notificationModels,
            metadata: Metadata(unreadCount: 2),
          );

          when(
            mockRemoteDataSource.getNotifications(),
          ).thenAnswer((_) async => notificationResponse);

          // Act
          final result = await repo.getNotifications();

          // Assert
          expect(result, isA<SuccessResponse<NotificationData>>());
          final data = (result as SuccessResponse<NotificationData>).data;
          expect(data.notifications.length, 2);
          expect(data.unreadCount, 2);
          expect(data.notifications[0].title, 'Welcome');
          expect(data.notifications[0].body, 'Welcome to our app');
          expect(data.notifications[1].title, 'New Offer');
          expect(data.notifications[1].body, 'Check out our new offers');
          verify(mockRemoteDataSource.getNotifications()).called(1);
        },
      );

      test(
        'should return SuccessResponse with empty list and zero unread count when notifications is null',
        () async {
          // Arrange
          final notificationResponse = NotificationResponse(
            message: 'Success',
            notifications: null,
            metadata: null,
          );

          when(
            mockRemoteDataSource.getNotifications(),
          ).thenAnswer((_) async => notificationResponse);

          // Act
          final result = await repo.getNotifications();

          // Assert
          expect(result, isA<SuccessResponse<NotificationData>>());
          final data = (result as SuccessResponse<NotificationData>).data;
          expect(data.notifications, isEmpty);
          expect(data.unreadCount, 0);
          verify(mockRemoteDataSource.getNotifications()).called(1);
        },
      );

      test(
        'should return SuccessResponse with empty list when notifications is empty',
        () async {
          // Arrange
          final notificationResponse = NotificationResponse(
            message: 'Success',
            notifications: [],
            metadata: Metadata(unreadCount: 0),
          );

          when(
            mockRemoteDataSource.getNotifications(),
          ).thenAnswer((_) async => notificationResponse);

          // Act
          final result = await repo.getNotifications();

          // Assert
          expect(result, isA<SuccessResponse<NotificationData>>());
          final data = (result as SuccessResponse<NotificationData>).data;
          expect(data.notifications, isEmpty);
          expect(data.unreadCount, 0);
          verify(mockRemoteDataSource.getNotifications()).called(1);
        },
      );

      test('should return ErrorResponse when remote call fails', () async {
        // Arrange
        final exception = Exception('Network error');
        when(mockRemoteDataSource.getNotifications()).thenThrow(exception);

        // Act
        final result = await repo.getNotifications();

        // Assert
        expect(result, isA<ErrorResponse<NotificationData>>());
        verify(mockRemoteDataSource.getNotifications()).called(1);
      });
    });
  });
}
