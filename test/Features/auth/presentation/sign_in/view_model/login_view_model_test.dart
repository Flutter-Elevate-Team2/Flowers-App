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
      SuccessResponse(
        data: LoginEntity(token: "dummy", message: "dummy", user: null),
      ),
    );

    mockLoginUseCase = MockLoginUseCase();
    viewModel = LoginViewModel(mockLoginUseCase);
  });

  tearDown(() => viewModel.close());

  group('LoginViewModel (Standard Tests)', () {
    test('ToggleRememberMe updates isRememberMe state', () {
      // Initial check
      expect(viewModel.state.isRememberMe, false);

      // ASSERT
      expectLater(
        viewModel.stream,
        emits(predicate<LoginState>((s) => s.isRememberMe == true)),
      );

      // ACT
      viewModel.doIntent(ToggleRememberMeEvent());
    });

    test('Login emits [Loading, Success] when usecase succeeds', () async {
      // ARRANGE
      final tEntity = LoginEntity(token: "token", message: "Success", user: null);

      when(mockLoginUseCase.call(
        email: anyNamed('email'),
        password: anyNamed('password'),
        isRememberMe: anyNamed('isRememberMe'),
      )).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ASSERT
      final expectedStates = [
        predicate<LoginState>((s) => s.loginState?.isLoading == true),
        predicate<LoginState>((s) =>
            s.loginState?.isLoading == false &&
            s.loginState?.data == tEntity),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      // ACT
      viewModel.doIntent(LoginButtonClickedEvent(email: 'test', password: 'pass'));
    });

    test('GuestLogin emits success immediately', () {
      // ASSERT
      final expectedStates = [
        predicate<LoginState>((s) =>
            s.loginState?.isLoading == false &&
            s.loginState?.data?.token == "guest"),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      // ACT
      viewModel.doIntent(GuestLoginClickedEvent());
    });
  });
}
