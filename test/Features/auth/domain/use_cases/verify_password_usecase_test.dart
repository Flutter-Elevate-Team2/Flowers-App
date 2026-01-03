import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
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
  late VerifyPasswordUsecase verifyPasswordUsecase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    provideDummy<BaseResponse<VerifyPasswordEntity>>(
      SuccessResponse(
        data: VerifyPasswordEntity(status: "dummy"),
      ),
    );

    mockAuthRepo = MockAuthRepoContract();
    verifyPasswordUsecase = VerifyPasswordUsecase(mockAuthRepo);
  });

  final tRequest = VerifyPasswordRequest(resetCode: "123456");
  final tEntity = VerifyPasswordEntity(status: "Verified");

  test('should call AuthRepo.verifyPassword and return SuccessResponse', () async {
    // ARRANGE
    when(mockAuthRepo.verifyPassword(any))
        .thenAnswer((_) async => SuccessResponse(data: tEntity));

    // ACT
    final result = await verifyPasswordUsecase.verifyPassword(tRequest);

    // ASSERT
    expect(result, isA<SuccessResponse<VerifyPasswordEntity>>());
    verify(mockAuthRepo.verifyPassword(tRequest)).called(1);
  });
}
