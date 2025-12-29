import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/login_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_event.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginState());

  void doIntent(LoginEvent event) {
    switch (event) {
      case LoginInitialEvent():
        _onInit();
        break;
      case ToggleRememberMeEvent():
        _toggleRememberMe();
        break;
      case UserTypingEvent():
        _resetErrorState();
        break;
      case LoginButtonClickedEvent():
        _handleLogin(event);
        break;
      case GuestLoginClickedEvent():
        _handleGuestLogin();
        break;
    }
  }

  void _onInit() {
    emit(LoginState());
  }

  void _toggleRememberMe() {
    emit(state.copyWith(
      isRememberMe: !state.isRememberMe,
      loginState: BaseState(),
    ));
  }

  void _resetErrorState() {
    if (state.loginState?.errorMessage != null || state.loginState?.isLoading == true) {
      emit(state.copyWith(loginState: BaseState()));
    }
  }

  Future<void> _handleLogin(LoginButtonClickedEvent event) async {
    emit(state.copyWith(loginState: BaseState(isLoading: true)));

    final response = await _loginUseCase.call(
      email: event.email,
      password: event.password,
      isRememberMe: state.isRememberMe,
    );

    switch (response) {
      case SuccessResponse<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;

      case ErrorResponse<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  void _handleGuestLogin() {
    // Fake success for guest
    emit(state.copyWith(
        loginState: BaseState(
            isLoading: false,
            data: LoginEntity(token: "guest", message: "Guest", user: null)
        )
    ));
  }
}