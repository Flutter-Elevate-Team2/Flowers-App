import 'package:equatable/equatable.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

import '../../../data/models/forget_password/responce/forget_password_response.dart';
import '../../../data/models/forget_password/responce/reset_password_response.dart';
import '../../../data/models/forget_password/responce/verify_password_response.dart';

class ForgetPasswordState with EquatableMixin {
  final BaseState<ForgetPasswordResponse> sendOtpState;
  final BaseState<VerifyPasswordResponse> verifyOtpState;
  final BaseState<ResetPasswordResponse> resetPasswordState;
  ForgetPasswordState({
    required this.sendOtpState,
    required this.resetPasswordState,
    required this.verifyOtpState,
  });

  factory ForgetPasswordState.initial() {
    return ForgetPasswordState(
      sendOtpState: BaseState(),
      resetPasswordState: BaseState(),
      verifyOtpState: BaseState(),
    );
  }
  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordResponse>? sendOtpState,
    BaseState<VerifyPasswordResponse>? verifyOtpState,
    BaseState<ResetPasswordResponse>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      sendOtpState: sendOtpState ?? this.sendOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
    );
  }

  @override
  List<Object?> get props => [sendOtpState, verifyOtpState, resetPasswordState];
}
