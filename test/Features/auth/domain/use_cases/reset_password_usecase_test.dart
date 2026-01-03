import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
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
  late ResetPasswordUsecase resetPasswordUsecase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    provideDummy<BaseResponse<ResetPasswordEntity>>(
      SuccessResponse(
        data: ResetPasswordEntity(message: "dummy", token: "dummy"),
      ),
    );

    mockAuthRepo = MockAuthRepoContract();
    resetPasswordUsecase = ResetPasswordUsecase(mockAuthRepo);
  });

  final tRequest = ResetPasswordRequest(email: "test@test.com", newPassword: "new");
  final tEntity = ResetPasswordEntity(message: "Done", token: "token");

  test('should call AuthRepo.resetPassword and return SuccessResponse', () async {
    // ARRANGE
    when(mockAuthRepo.resetPassword(any))
        .thenAnswer((_) async => SuccessResponse(data: tEntity));

    // ACT
    final result = await resetPasswordUsecase.resetPassword(tRequest);

    // ASSERT
    expect(result, isA<SuccessResponse<ResetPasswordEntity>>());
    verify(mockAuthRepo.resetPassword(tRequest)).called(1);
  });
}
