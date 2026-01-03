import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class LoginState {
  final BaseState<LoginEntity>? loginState;
  final bool isRememberMe;

  LoginState({
    this.loginState,
    this.isRememberMe = false,
  });

  LoginState copyWith({
    BaseState<LoginEntity>? loginState,
    bool? isRememberMe,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}
