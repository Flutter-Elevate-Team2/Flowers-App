import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepoContract])
void main() {
  provideDummy<BaseResponse<ChangePasswordEntity>>(
    SuccessResponse(
      data: ChangePasswordEntity(message: '', token: ''),
    ),
  );
  late ChangePasswordUseCase useCase;
  late MockProfileRepoContract mockRepo;

  setUp(() {
    mockRepo = MockProfileRepoContract();
    useCase = ChangePasswordUseCase(mockRepo);
  });

  group('ChangePasswordUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
      const oldPassword = 'oldPassword';
      const newPassword = 'newPassword';

      final changePasswordEntity = ChangePasswordEntity(
        message: 'Success',
        token: 'token',
      );
      final successResponse = SuccessResponse<ChangePasswordEntity>(
        data: changePasswordEntity,
      );

      when(
        mockRepo.changePassword(any, any),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call(oldPassword, newPassword);

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<ChangePasswordEntity>>());
      verify(mockRepo.changePassword(any, any)).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      const oldPassword = 'oldPassword';
      const newPassword = 'newPassword';
      const errorMessage = 'Failed to change password';
      final errorResponse = ErrorResponse<ChangePasswordEntity>(
        errorMessage: errorMessage,
      );

      when(
        mockRepo.changePassword(any, any),
      ).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call(oldPassword, newPassword);

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<ChangePasswordEntity>>());
      verify(mockRepo.changePassword(any, any)).called(1);
    });
  });
}
