import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/login_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_event.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_state.dart';
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

  final loginEvent = LoginButtonEvent(
    email: 'user@example.com',
    password: 'password1234@',
  );

  final loginEntity = LoginEntity(
    token: 'token123',
    message: 'message state',
    user: null,
  );

  group('LoginViewModel bloc tests', () {
    blocTest<LoginViewModel, LoginState>(
      'emits [loading, success] when login succeeds',
      build: () {
        when(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
              (_) async => SuccessResponse<LoginEntity>(data: loginEntity),
        );
        return viewModel;
      },
      act: (bloc) => viewModel.doIntent(loginEvent),
      expect: () => [
        isA<LoginState>().having(
              (s) => s.loginState?.isLoading,
          'loading',
          true,
        ),
        isA<LoginState>()
            .having(
              (s) => s.loginState?.isLoading,
          'loading finished',
          false,
        )
            .having(
              (s) => s.loginState?.data,
          'success data',
          loginEntity,
        )
            .having(
              (s) => s.loginState?.errorMessage,
          'no error',
          null,
        ),
      ],
      verify: (_) {
        verify(
          mockLoginUseCase.call(
            email: loginEvent.email,
            password: loginEvent.password,
          ),
        ).called(1);
      },
    );

    blocTest<LoginViewModel, LoginState>(
      'emits [loading, error] when login fails',
      build: () {
        when(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
              (_) async =>  ErrorResponse<LoginEntity>(
            errorMessage: 'Login failed',
          ),
        );
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(loginEvent),
      expect: () => [
        isA<LoginState>().having(
              (s) => s.loginState?.isLoading,
          'loading',
          true,
        ),
        isA<LoginState>()
            .having(
              (s) => s.loginState?.isLoading,
          'loading finished',
          false,
        )
            .having(
              (s) => s.loginState?.data,
          'no data',
          null,
        )
            .having(
              (s) => s.loginState?.errorMessage,
          'error message',
          'Login failed',
        ),
      ],
    );

    blocTest<LoginViewModel, LoginState>(
      'toggles remember me state',
      build: () => viewModel,
      act: (cubit) => cubit.doIntent(RememberMeEvent(value: true)),
      expect: () => [
        isA<LoginState>().having(
              (s) => s.isRememberMe,
          'remember me toggled',
          true,
        ),
      ],
    );
  });
}
