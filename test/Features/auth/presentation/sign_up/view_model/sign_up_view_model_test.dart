import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_events.dart';
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
    provideDummy<BaseResponse<SignupEntity>>(ErrorResponse(errorMessage: ''));
    mockSignupUseCase = MockSignupUseCase();
    viewModel = SignUpViewModel(mockSignupUseCase);
  });

  final tEvent = OnSignUpClickEvent(
    firstName: "Test",
    lastName: "User",
    email: "test@example.com",
    phone: "1234567890",
    password: "password123",
    confirmPassword: "password123",
    gender: "male",
  );

  final tSignupEntity = SignupEntity(
    token: "token123",
    user: SignupUserEntity(
      firstName: "Test",
      lastName: "User",
      email: "test@example.com",
      phone: "1234567890",
      gender: "male",
    ),
  );

  group('doIntent - OnSignUpClickEvent', () {
    test(
      'should emit loading then success state when use case returns SuccessResponse',
      () async {
        // ARRANGE
        when(
          mockSignupUseCase.call(any),
        ).thenAnswer((_) async => SuccessResponse(data: tSignupEntity));

        // ACT
        viewModel.doIntent(tEvent);

        // ASSERT
        expect(viewModel.state.signUpState?.isLoading, true);

        // Wait for the async operation to complete
        await pumpEventQueue();

        expect(viewModel.state.signUpState?.isLoading, false);
        expect(viewModel.state.signUpState?.data, tSignupEntity);
        expect(viewModel.state.signUpState?.errorMessage, null);
      },
    );

    test(
      'should emit loading then error state when use case returns ErrorResponse',
      () async {
        // ARRANGE
        const tErrorMessage = "Registration failed";
        when(
          mockSignupUseCase.call(any),
        ).thenAnswer((_) async => ErrorResponse(errorMessage: tErrorMessage));

        // ACT
        viewModel.doIntent(tEvent);

        // ASSERT
        expect(viewModel.state.signUpState?.isLoading, true);

        // Wait for the async operation to complete
        await pumpEventQueue();

        expect(viewModel.state.signUpState?.isLoading, false);
        expect(viewModel.state.signUpState?.data, null);
        expect(viewModel.state.signUpState?.errorMessage, tErrorMessage);
      },
    );
  });
}
