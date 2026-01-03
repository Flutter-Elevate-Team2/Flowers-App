import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  late SignupUseCase signupUseCase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    provideDummy<BaseResponse<SignupEntity>>(
      SuccessResponse(
        data: SignupEntity(token: "dummy", user: null),
      ),
    );

    mockAuthRepo = MockAuthRepoContract();
    signupUseCase = SignupUseCase(mockAuthRepo);
  });

  final tRequest = SignupRequest(
    firstName: "Ahmed",
    lastName: "Ali",
    email: "test@test.com",
    password: "pass",
    rePassword: "pass",
    phone: "010",
    gender: "male",
  );

  final tSignupEntity = SignupEntity(token: "token", user: null);

  test('should call AuthRepo.signUp and return SuccessResponse', () async {
    // ARRANGE
    when(mockAuthRepo.signUp(any))
        .thenAnswer((_) async => SuccessResponse(data: tSignupEntity));

    // ACT
    final result = await signupUseCase.call(tRequest);

    // ASSERT
    expect(result, isA<SuccessResponse<SignupEntity>>());
    verify(mockAuthRepo.signUp(tRequest)).called(1);
  });

  test('should return ErrorResponse when AuthRepo fails', () async {
    // ARRANGE
    when(mockAuthRepo.signUp(any))
        .thenAnswer((_) async => ErrorResponse(errorMessage: "Error"));

    // ACT
    final result = await signupUseCase.call(tRequest);

    // ASSERT
    expect(result, isA<ErrorResponse>());
    verify(mockAuthRepo.signUp(tRequest)).called(1);
  });
}
