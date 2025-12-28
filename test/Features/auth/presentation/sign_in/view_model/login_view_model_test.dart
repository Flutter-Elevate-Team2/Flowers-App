import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/login_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_event.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late LoginViewModel viewModel;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    provideDummy<BaseResponse<LoginEntity>>(
      ErrorResponse<LoginEntity>(errorMessage: ''),
    );
    mockLoginUseCase = MockLoginUseCase();
    viewModel = LoginViewModel(mockLoginUseCase);
  });

  final loginEvent = LoginButtonClickedEvent(
    email: 'user@example.com',
    password: 'password1234@',
  );

  final loginEntity = LoginEntity(
    token: 'token123',
    message: 'message state',
    user: null,
  );

  group('LoginViewModel bloc tests', () {
    test(
        'emits [loading, success] when login succeeds',
            () async {
          when(
            mockLoginUseCase.call(
              email: anyNamed('email'),
              password: anyNamed('password'),
            ),
          ).thenAnswer(
                (_) async => SuccessResponse<LoginEntity>(data: loginEntity),
          );

          viewModel.doIntent(loginEvent);

          expect(viewModel.state.loginState?.isLoading, true);
          await pumpEventQueue();

          expect(viewModel.state.loginState?.isLoading, false);
          expect(viewModel.state.loginState?.data, loginEntity);
          expect(viewModel.state.loginState?.errorMessage, null);
        }
    );

    test(
        'emits [loading, error] when login fails',
            ()async {
          const testErrorMessage = "Registration failed";

          when(
            mockLoginUseCase.call(
              email: anyNamed('email'),
              password: anyNamed('password'),
            ),
          ).thenAnswer(
                (_) async =>  ErrorResponse<LoginEntity>(
              errorMessage: testErrorMessage,
            ),
          );
          viewModel.doIntent(loginEvent);
          expect(viewModel.state.loginState?.isLoading, true);
          await pumpEventQueue();

          expect(viewModel.state.loginState?.isLoading, false);
          expect(viewModel.state.loginState?.data, null);
          expect(viewModel.state.loginState?.errorMessage, testErrorMessage);
        }
    );
    test(
      'clicked on remember me button when RememberMeEvent is triggered',
          () {
        expect(viewModel.state.isRememberMe, false);

        viewModel.doIntent(
          ToggleRememberMeEvent(),
        );

        expect(viewModel.state.isRememberMe, true);
      },
    );
  });
}