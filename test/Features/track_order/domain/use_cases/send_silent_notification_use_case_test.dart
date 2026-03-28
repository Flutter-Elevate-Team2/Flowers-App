import 'package:flowers_app/Features/track_order/domain/repo/send_silent_notification_repo_contract.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/send_silent_notification_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSendSilentNotificationRepositoryContract extends Mock
    implements SendSilentNotificationRepositoryContract {}

void main() {
  late SendSilentNotificationUseCase useCase;
  late MockSendSilentNotificationRepositoryContract mockRepository;

  setUp(() {
    mockRepository = MockSendSilentNotificationRepositoryContract();
    useCase = SendSilentNotificationUseCase(mockRepository);
  });

  const tOrderId = "order_123";
  const tDriverToken = "token_abc";

  test('should call sendSilentNotification from repository', () async {
    // Arrange
    final tResponse = SuccessResponse<bool>(data: true);
    when(
      () => mockRepository.sendSilentNotification(
        orderId: any(named: 'orderId'),
        driverToken: any(named: 'driverToken'),
      ),
    ).thenAnswer((_) async => tResponse);

    // Act
    final result = await useCase(orderId: tOrderId, driverToken: tDriverToken);

    // Assert
    expect(result, tResponse);
    verify(
      () => mockRepository.sendSilentNotification(
        orderId: tOrderId,
        driverToken: tDriverToken,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
