import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verify_password_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  late VerifyPasswordUsecase useCase;
  late MockAuthRepoContract mockRepo;

  setUp(() {
    mockRepo = MockAuthRepoContract();
    useCase = VerifyPasswordUsecase(mockRepo);
  });

  final tRequest = VerifyPasswordRequest(resetCode: "123456");
  final tEntity = VerifyPasswordEntity(status: "Success");

  test(
    'should call AuthRepo.verifyPassword and return SuccessResponse',
    () async {
      // ARRANGE
      when(
        mockRepo.verifyPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ACT
      final result = await useCase.verifyPassword(tRequest);

      // ASSERT
      expect(result, isA<SuccessResponse<VerifyPasswordEntity>>());
      expect((result as SuccessResponse).data, tEntity);
      verify(mockRepo.verifyPassword(tRequest)).called(1);
    },
  );

  test(
    'should return ErrorResponse when AuthRepo returns ErrorResponse',
    () async {
      // ARRANGE
      final tError = ErrorResponse<VerifyPasswordEntity>(
        errorMessage: "Invalid Code",
      );

      when(mockRepo.verifyPassword(any)).thenAnswer((_) async => tError);

      // ACT
      final result = await useCase.verifyPassword(tRequest);

      // ASSERT
      expect(result, isA<ErrorResponse<VerifyPasswordEntity>>());
      expect((result as ErrorResponse).errorMessage, "Invalid Code");
      verify(mockRepo.verifyPassword(tRequest)).called(1);
    },
  );
}
