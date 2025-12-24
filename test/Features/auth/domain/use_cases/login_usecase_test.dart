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
        data: LoginEntity(token: '', message: '', user: null),
      ),
    );

    mockAuthRepo = MockAuthRepoContract();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  test('when call LoginUseCase it should call repo with correct params', () async {
    // Arrange
    const email = 'malak@gmail.com';
    const password = 'Elevate@123';

    final loginEntity = LoginEntity(
      token: 'token',
      message: '',
      user: null,
    );

    when(mockAuthRepo.login(email, password))
        .thenAnswer((_) async => SuccessResponse(data: loginEntity));

    // Act
    final result =
    await loginUseCase(email: email, password: password);

    // Assert
    expect(result, isA<SuccessResponse<LoginEntity>>());
    expect(
      (result as SuccessResponse<LoginEntity>).data.token,
      'token',
    );
    verify(mockAuthRepo.login(email, password)).called(1);
  });
}