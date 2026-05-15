import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/guest_login_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/login_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_event.dart';
import 'package:flowers_app/Features/auth/presentation/sign_in/view_model/login_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final GuestLoginUseCase _guestLoginUseCase;
  final SessionController _sessionController;

  LoginViewModel(
    this._loginUseCase,
    this._guestLoginUseCase,
    this._sessionController,
  ) : super(LoginState());

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
    emit(
      state.copyWith(
        isRememberMe: !state.isRememberMe,
        loginState: BaseState(),
      ),
    );
  }

  void _resetErrorState() {
    if (state.loginState?.errorMessage != null ||
        state.loginState?.isLoading == true) {
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
        _sessionController.notifyLogin();

        emit(
          state.copyWith(
            loginState: BaseState(isLoading: false, data: response.data),
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

  void _handleGuestLogin() async {
    _sessionController.notifyLogout(SessionEndReason.guest);

    final guestUser = await _guestLoginUseCase();
    emit(
      state.copyWith(
        loginState: BaseState(isLoading: false, data: guestUser),
        isRememberMe: false,
      ),
    );
  }
}
