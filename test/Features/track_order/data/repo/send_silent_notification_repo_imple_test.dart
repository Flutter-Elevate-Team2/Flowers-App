import 'package:flowers_app/Features/track_order/data/data_sources/remote/send_silent_notification_remot_data_source_contract.dart';
import 'package:flowers_app/Features/track_order/data/repo/send_silent_notification_repo_imple.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([SendSilentNotificationDataSourceContract])
import 'send_silent_notification_repo_imple_test.mocks.dart';

void main() {
  late SendSilentNotificationRepositoryImple repository;
  late MockSendSilentNotificationDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockSendSilentNotificationDataSourceContract();
    repository = SendSilentNotificationRepositoryImple(mockRemoteDataSource);
  });

  const tOrderId = "order_123";
  const tDriverToken = "token_abc";

  group('sendSilentNotification', () {
    test(
      'should return SuccessResponse<bool>(data: true) when data source succeeds',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.sendSilentNotificationToDriver(
            orderId: tOrderId,
            driverToken: tDriverToken,
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.sendSilentNotification(
          orderId: tOrderId,
          driverToken: tDriverToken,
        );

        // Assert
        expect(result, isA<SuccessResponse<bool>>());
        expect((result as SuccessResponse<bool>).data, true);
      },
    );

    test('should return ErrorResponse when data source fails', () async {
      // Arrange
      when(
        mockRemoteDataSource.sendSilentNotificationToDriver(
          orderId: tOrderId,
          driverToken: tDriverToken,
        ),
      ).thenThrow(Exception("Network Error"));

      // Act
      final result = await repository.sendSilentNotification(
        orderId: tOrderId,
        driverToken: tDriverToken,
      );

      // Assert
      expect(result, isA<ErrorResponse<bool>>());
    });
  });
}
