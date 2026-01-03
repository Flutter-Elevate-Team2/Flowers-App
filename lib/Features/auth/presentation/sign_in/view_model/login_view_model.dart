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
      case LoginInitial():
        _onInit();
        break;
      case RememberMeEvent():
        _rememberMe();
        break;
      case LoginButtonEvent():
        _handleLoginButtonClicked(event);
        break;

      case GuestLoginEvent():
        _onGuestLogin();
        break;
      case SignUpEvent():
        _onSignUp();
        break;
    }
  }

  void _onInit() {
    emit(
      state.copyWith(
        loginState: null,
        isRememberMe: false,
        isButtonClicked: false,
      ),
    );
  }

  void _rememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }

  // Future<void> _validate(String email , String password) async {
  //   if (formKey.currentState?.validate() ?? false) {
  //     final event = LoginButtonEvent(
  //       email: email,
  //       password: password,
  //     );
  //
  //     _handleLoginButtonClicked(event);
  //   }
  // }

  Future<void> _handleLoginButtonClicked(LoginButtonEvent event) async {
    emit(
      state.copyWith(
        loginState: BaseState<LoginEntity>(isLoading: true,),
      ),
    );
    final response = await _loginUseCase.call(
      email: event.email,
      password: event.password,
    );

    switch (response) {
      case SuccessResponse<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState<LoginEntity>(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<LoginEntity>():
        emit(
          state.copyWith(
            loginState: BaseState<LoginEntity>(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }

  void _onGuestLogin() {
    //TODO: Handle guest login logic here
  }

  void _onSignUp() {
    //TODO: Handle guest login logic here

  }
}
