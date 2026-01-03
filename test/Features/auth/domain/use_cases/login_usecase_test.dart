import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/login_usecase.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    provideDummy<BaseResponse<LoginEntity>>(
      SuccessResponse(
        data: LoginEntity(token: "dummy", message: "dummy", user: null),
      ),
    );

    mockAuthRepo = MockAuthRepoContract();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  const tEmail = "test@test.com";
  const tPassword = "password123";
  const tIsRememberMe = true;

  // Dummy Entity
  final tLoginEntity = LoginEntity(token: "token", message: "success", user: null);

  test('should call AuthRepo.login and return SuccessResponse', () async {
    // ARRANGE
    when(mockAuthRepo.login(any, any, any))
        .thenAnswer((_) async => SuccessResponse(data: tLoginEntity));

    // ACT
    final result = await loginUseCase.call(
      email: tEmail,
      password: tPassword,
      isRememberMe: tIsRememberMe,
    );

    // ASSERT
    expect(result, isA<SuccessResponse<LoginEntity>>());
    verify(mockAuthRepo.login(tEmail, tPassword, tIsRememberMe)).called(1);
  });

  test('should return ErrorResponse when AuthRepo fails', () async {
    // ARRANGE
    when(mockAuthRepo.login(any, any, any))
        .thenAnswer((_) async => ErrorResponse(errorMessage: "Login Failed"));

    // ACT
    final result = await loginUseCase.call(
      email: tEmail,
      password: tPassword,
      isRememberMe: tIsRememberMe,
    );

    // ASSERT
    expect(result, isA<ErrorResponse>());
    expect((result as ErrorResponse).errorMessage, "Login Failed");
    verify(mockAuthRepo.login(tEmail, tPassword, tIsRememberMe)).called(1);
  });
}
