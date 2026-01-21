import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepoContract, SharedPreferences, SessionController])
void main() {
  provideDummy<BaseResponse<String>>(SuccessResponse(data: ''));
  late LogoutUseCase useCase;
  late MockProfileRepoContract mockRepo;
  late MockSharedPreferences mockPrefs;
  late MockSessionController mockSession;

  setUp(() {
    mockRepo = MockProfileRepoContract();
    mockPrefs = MockSharedPreferences();
    mockSession = MockSessionController();
    useCase = LogoutUseCase(mockRepo, mockPrefs, mockSession);
  });

  group('LogoutUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
      const successMessage = 'Logged out successfully';
      final successResponse = SuccessResponse<String>(data: successMessage);

      when(mockRepo.logout()).thenAnswer((_) async => successResponse);
      when(mockPrefs.remove(any)).thenAnswer((_) async => true);
      when(mockSession.expireSession()).thenReturn(null);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<String>>());
      verify(mockRepo.logout()).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      const errorMessage = 'Failed to logout';
      final errorResponse = ErrorResponse<String>(errorMessage: errorMessage);

      when(mockRepo.logout()).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<String>>());
      verify(mockRepo.logout()).called(1);
    });
  });
}
