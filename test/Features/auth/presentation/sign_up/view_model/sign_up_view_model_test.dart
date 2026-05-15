import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_events.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_states.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_view_model_test.mocks.dart';

@GenerateMocks([SignupUseCase])
void main() {
  late SignUpViewModel viewModel;
  late MockSignupUseCase mockSignupUseCase;

  setUp(() {
    provideDummy<BaseResponse<SignupEntity>>(
      SuccessResponse(
        data: SignupEntity(token: "dummy", user: null),
      ),
    );

    mockSignupUseCase = MockSignupUseCase();
    viewModel = SignUpViewModel(mockSignupUseCase);
  });

  tearDown(() => viewModel.close());

  group('SignUpViewModel (Standard Tests)', () {
    final tEvent = OnSignUpClickEvent(
      firstName: "A",
      lastName: "B",
      email: "e",
      phone: "p",
      password: "pass",
      confirmPassword: "pass",
      gender: "m",
    );

    test('SignUp emits [Loading, Success] when usecase succeeds', () async {
      // ARRANGE
      final tEntity = SignupEntity(token: "token", user: null);
      when(mockSignupUseCase.call(any))
          .thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ASSERT
      final expectedStates = [
        // 1. Loading
        predicate<SignUpStates>((s) => s.signUpState?.isLoading == true),
        // 2. Success
        predicate<SignUpStates>((s) =>
            s.signUpState?.isLoading == false &&
            s.signUpState?.data == tEntity),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      // ACT
      viewModel.doIntent(tEvent);
    });

    test('SignUp emits [Loading, Error] when usecase fails', () async {
      // ARRANGE
      when(mockSignupUseCase.call(any))
          .thenAnswer((_) async => ErrorResponse(errorMessage: "Error msg"));

      // ASSERT
      final expectedStates = [
        // 1. Loading
        predicate<SignUpStates>((s) => s.signUpState?.isLoading == true),
        // 2. Error
        predicate<SignUpStates>((s) =>
            s.signUpState?.isLoading == false &&
            s.signUpState?.errorMessage == "Error msg"),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      // ACT
      viewModel.doIntent(tEvent);
    });
  });
}
