import 'package:flowers_app/Features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flowers_app/Features/notifications/domain/use_case/mark_notification_as_read_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mark_notification_as_read_use_case_test.mocks.dart';

@GenerateMocks([NotificationRepoContract])
void main() {
  late MarkNotificationAsReadUseCase useCase;
  late MockNotificationRepoContract mockRepo;

  setUpAll(() {
    // حل مشكلة الـ MissingDummyValueError
    // بنعرف Mockito إزاي يتعامل مع الـ Abstract class كقيمة افتراضية
    provideDummy<BaseResponse<void>>(SuccessResponse<void>(data: null));
  });

  setUp(() {
    mockRepo = MockNotificationRepoContract();
    useCase = MarkNotificationAsReadUseCase(mockRepo);
  });

  group('MarkNotificationAsReadUseCase', () {
    const tNotificationId = 'notif_123';

    test('delegates to repo.markNotificationAsRead with correct id', () async {
      // Arrange
      final successResponse = SuccessResponse<void>(data: null);
      when(mockRepo.markNotificationAsRead(tNotificationId))
          .thenAnswer((_) async => successResponse);

      // Act
      await useCase.call(tNotificationId);

      // Assert
      verify(mockRepo.markNotificationAsRead(tNotificationId)).called(1);
    });

    test('returns SuccessResponse when repository call is successful', () async {
      // Arrange
      final successResponse = SuccessResponse<void>(data: null);
      when(mockRepo.markNotificationAsRead(tNotificationId))
          .thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call(tNotificationId);

      // Assert
      expect(result, isA<SuccessResponse<void>>());
    });

    test('returns ErrorResponse when repository call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse<void>(errorMessage: 'Failed');
      when(mockRepo.markNotificationAsRead(tNotificationId))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call(tNotificationId);

      // Assert
      expect(result, isA<ErrorResponse<void>>());
      expect((result as ErrorResponse).errorMessage, 'Failed');
    });
  });
}