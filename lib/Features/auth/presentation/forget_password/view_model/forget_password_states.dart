import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class ForgetPasswordState {
  final BaseState<ForgetPasswordEntity>? sendOtpState;
  final BaseState<VerifyPasswordEntity>? verifyOtpState;
  final BaseState<ResetPasswordEntity>? resetPasswordState;

  ForgetPasswordState({
    this.sendOtpState,
    this.verifyOtpState,
    this.resetPasswordState,
  });

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordEntity>? sendOtpState,
    BaseState<VerifyPasswordEntity>? verifyOtpState,
    BaseState<ResetPasswordEntity>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      sendOtpState: sendOtpState ?? this.sendOtpState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
