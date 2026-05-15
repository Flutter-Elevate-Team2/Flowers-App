import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  late ForgetPasswordUsecase forgetPasswordUsecase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      SuccessResponse(
        data: ForgetPasswordEntity(message: "dummy", info: "dummy"),
      ),
    );

    mockAuthRepo = MockAuthRepoContract();
    forgetPasswordUsecase = ForgetPasswordUsecase(mockAuthRepo);
  });

  final tRequest = ForgetPasswordRequest(email: "test@test.com");
  final tEntity = ForgetPasswordEntity(message: "Email Sent", info: "info");

  test(
    'should call AuthRepo.forgetPassword and return SuccessResponse',
    () async {
      // ARRANGE
      when(
        mockAuthRepo.forgetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ACT
      final result = await forgetPasswordUsecase.forgetPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<ForgetPasswordEntity>>());
      verify(mockAuthRepo.forgetPassword(tRequest)).called(1);
    },
  );
}
