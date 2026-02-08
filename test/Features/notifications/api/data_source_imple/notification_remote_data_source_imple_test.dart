import 'package:flowers_app/Features/notifications/api/api_client/notification_api_client.dart';
import 'package:flowers_app/Features/notifications/api/data_source_imple/notification_remote_data_source_imple.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_response.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_response/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([NotificationApi])
void main() {
  late NotificationRemoteDataSourceImple dataSource;
  late MockNotificationApi mockNotificationApi;

  setUp(() {
    mockNotificationApi = MockNotificationApi();
    dataSource = NotificationRemoteDataSourceImple(mockNotificationApi);
  });

  group('NotificationRemoteDataSourceImple Tests', () {
    test(
      'getNotifications should return NotificationResponse from API',
      () async {
        // Arrange
        final notificationModels = [
          NotificationModel(title: 'Test', body: 'Test body'),
          NotificationModel(title: 'Another', body: 'Another body'),
        ];
        final notificationResponse = NotificationResponse(
          message: 'Success',
          notifications: notificationModels,
        );

        when(
          mockNotificationApi.getNotifications(),
        ).thenAnswer((_) async => notificationResponse);

        // Act
        final result = await dataSource.getNotifications();

        // Assert
        expect(result, notificationResponse);
        expect(result.message, 'Success');
        expect(result.notifications?.length, 2);
        verify(mockNotificationApi.getNotifications()).called(1);
      },
    );

    test(
      'getNotifications should return empty notification list from API',
      () async {
        // Arrange
        final notificationResponse = NotificationResponse(
          message: 'Success',
          notifications: [],
        );

        when(
          mockNotificationApi.getNotifications(),
        ).thenAnswer((_) async => notificationResponse);

        // Act
        final result = await dataSource.getNotifications();

        // Assert
        expect(result, notificationResponse);
        expect(result.notifications, isEmpty);
        verify(mockNotificationApi.getNotifications()).called(1);
      },
    );

    test('getNotifications should propagate exceptions from API', () async {
      // Arrange
      final exception = Exception('API Error');
      when(mockNotificationApi.getNotifications()).thenThrow(exception);

      // Act & Assert
      expect(() => dataSource.getNotifications(), throwsA(isA<Exception>()));
      verify(mockNotificationApi.getNotifications()).called(1);
    });
  });
}
