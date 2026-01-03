import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  late ResetPasswordUsecase useCase;
  late MockAuthRepoContract mockRepo;

  setUp(() {
    mockRepo = MockAuthRepoContract();
    useCase = ResetPasswordUsecase(mockRepo);
  });

  final tRequest = ResetPasswordRequest(
    email: "test@test.com",
    newPassword: "NewPassword123",
  );
  final tEntity = ResetPasswordEntity(
    message: "Password Changed Successfully",
    token: "token_123",
  );

  test(
    'should call AuthRepo.resetPassword and return SuccessResponse',
    () async {
      // ARRANGE
      when(
        mockRepo.resetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ACT
      final result = await useCase.resetPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<ResetPasswordEntity>>());
      expect((result as SuccessResponse).data, tEntity);
      verify(mockRepo.resetPassword(tRequest)).called(1);
    },
  );

  test(
    'should return ErrorResponse when AuthRepo returns ErrorResponse',
    () async {
      // ARRANGE
      final tError = ErrorResponse<ResetPasswordEntity>(
        errorMessage: "Server Error",
      );

      when(mockRepo.resetPassword(any)).thenAnswer((_) async => tError);

      // ACT
      final result = await useCase.resetPassword(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse<ResetPasswordEntity>>());
      expect((result as ErrorResponse).errorMessage, "Server Error");
      verify(mockRepo.resetPassword(tRequest)).called(1);
    },
  );
}
