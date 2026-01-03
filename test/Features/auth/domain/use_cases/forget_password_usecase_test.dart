import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request.dart';
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
  late ForgetPasswordUsecase useCase;
  late MockAuthRepoContract mockRepo;

  setUp(() {
    mockRepo = MockAuthRepoContract();
    useCase = ForgetPasswordUsecase(mockRepo);
  });

  final tRequest = ForgetPasswordRequest(email: "test@test.com");
  final tEntity = ForgetPasswordEntity(message: "Success", info: "Check inbox");

  test(
    'should call AuthRepo.forgetPassword and return SuccessResponse',
    () async {
      // ARRANGE
      when(
        mockRepo.forgetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ACT
      final result = await useCase.forgetPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<ForgetPasswordEntity>>());
      expect((result as SuccessResponse).data, tEntity);
      verify(mockRepo.forgetPassword(tRequest)).called(1);
    },
  );

  test(
    'should return ErrorResponse when AuthRepo returns ErrorResponse',
    () async {
      // ARRANGE
      final tError = ErrorResponse<ForgetPasswordEntity>(
        errorMessage: "No Internet",
      );

      when(mockRepo.forgetPassword(any)).thenAnswer((_) async => tError);

      // ACT
      final result = await useCase.forgetPassword(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse<ForgetPasswordEntity>>());
      expect((result as ErrorResponse).errorMessage, "No Internet");
      verify(mockRepo.forgetPassword(tRequest)).called(1);
    },
  );
}
