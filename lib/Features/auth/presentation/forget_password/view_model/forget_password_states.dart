import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/core/base_states/base_states.dart';


class ForgetPasswordState with EquatableMixin {
  final BaseState<ForgetPasswordResponce> sendOtpState;
  final BaseState<VerifyPasswordResponce> verifyOtpState;
  final BaseState<ResetPasswordResponce> resetPasswordState;

  ForgetPasswordState({
    required this.sendOtpState,
    required this.verifyOtpState,
    required this.resetPasswordState,
  });

  factory ForgetPasswordState.initial() {
    return ForgetPasswordState(
      sendOtpState: BaseState(),
      verifyOtpState: BaseState(),
      resetPasswordState: BaseState(),
    );
  }

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordResponce>? sendOtpState,
    BaseState<VerifyPasswordResponce>? verifyOtpState,
    BaseState<ResetPasswordResponce>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      sendOtpState: sendOtpState ?? this.sendOtpState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState:
      resetPasswordState ?? this.resetPasswordState,
    );
  }

  @override
  List<Object?> get props => [
    sendOtpState,
    verifyOtpState,
    resetPasswordState,
  ];
}
