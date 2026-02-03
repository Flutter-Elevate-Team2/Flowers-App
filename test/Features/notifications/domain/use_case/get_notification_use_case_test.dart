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
  provideDummy<BaseResponse<List<NotificationEntity>>>(
    SuccessResponse(data: []),
  );

  late GetNotificationUseCase useCase;
  late MockNotificationRepoContract mockRepo;

  setUp(() {
    mockRepo = MockNotificationRepoContract();
    useCase = GetNotificationUseCase(mockRepo);
  });

  group('GetNotificationUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
      final notifications = [
        NotificationEntity(
          title: 'Test Notification 1',
          body: 'This is a test notification',
        ),
        NotificationEntity(
          title: 'Test Notification 2',
          body: 'This is another test notification',
        ),
      ];
      final successResponse = SuccessResponse<List<NotificationEntity>>(
        data: notifications,
      );

      when(
        mockRepo.getNotifications(),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<List<NotificationEntity>>>());
      final data = (result as SuccessResponse<List<NotificationEntity>>).data;
      expect(data.length, 2);
      expect(data[0].title, 'Test Notification 1');
      expect(data[1].title, 'Test Notification 2');
      verify(mockRepo.getNotifications()).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      const errorMessage = 'Failed to fetch notifications';
      final errorResponse = ErrorResponse<List<NotificationEntity>>(
        errorMessage: errorMessage,
      );

      when(mockRepo.getNotifications()).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<List<NotificationEntity>>>());
      expect((result as ErrorResponse).errorMessage, errorMessage);
      verify(mockRepo.getNotifications()).called(1);
    });

    test('call should return empty list when no notifications', () async {
      // Arrange
      final successResponse = SuccessResponse<List<NotificationEntity>>(
        data: [],
      );

      when(
        mockRepo.getNotifications(),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<SuccessResponse<List<NotificationEntity>>>());
      expect((result as SuccessResponse).data, isEmpty);
      verify(mockRepo.getNotifications()).called(1);
    });
  });
}
