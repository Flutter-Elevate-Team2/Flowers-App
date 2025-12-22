import 'package:flowers_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';

import 'signup_usecase_test.mocks.dart';


@GenerateMocks([AuthRepoContract])
void main() {
  late SignupUseCase signupUseCase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepoContract();
    signupUseCase = SignupUseCase(mockAuthRepo);
  });

  final tRequest = SignupRequest(
    firstName: "Test", lastName: "User", email: "t@t.com",
    password: "P", rePassword: "P", phone: "123", gender: "male"
  );

  final tEntity = SignupEntity(user: null, token: "token");

  test('should call Repo.signUp and return SuccessResponse', () async {
    // ARRANGE
    when(mockAuthRepo.signUp(any))
        .thenAnswer((_) async => SuccessResponse(data: tEntity));

    // ACT
    final result = await signupUseCase.call(tRequest);

    // ASSERT
    expect(result, isA<SuccessResponse<SignupEntity>>());
    verify(mockAuthRepo.signUp(tRequest)).called(1);
  });
}
