import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUsecase _forgetPasswordUsecase;
  final VerifyPasswordUsecase _verifyPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;

  ForgetPasswordCubit(
    super.initialState,
    this._forgetPasswordUsecase,
    this._verifyPasswordUsecase,
    this._resetPasswordUsecase,
  );

  Future<void> doIntent(ForgetPasswordIntent intent) async {
    switch (intent) {
      case SendOtp():
        await _handleSendOtp(intent);
        break;
      case VerifyOtp():
        await _handleVerifyOtp(intent);
        break;
      case ResetPassword():
        await _handleResetPassword(intent);
        break;
    }
  }

  Future<void> _handleSendOtp(SendOtp intent) async {
    emit(state.copyWith(sendOtpState: BaseState(isLoading: true)));

    final request = ForgetPasswordRequest(email: intent.email);

    final response = await _forgetPasswordUsecase.forgetPassword(request);

    switch (response) {
      case SuccessResponse<ForgetPasswordResponce>():
        emit(
          state.copyWith(
            sendOtpState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;

      case ErrorResponse<ForgetPasswordResponce>():
        emit(
          state.copyWith(
            sendOtpState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _handleVerifyOtp(VerifyOtp intent) async {
    emit(state.copyWith(verifyOtpState: BaseState(isLoading: true)));

    final request = VerifyPasswordRequest(resetCode: intent.otp);

    final response = await _verifyPasswordUsecase.verifyPassword(request);

    switch (response) {
      case SuccessResponse<VerifyPasswordResponce>():
        emit(
          state.copyWith(
            verifyOtpState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;

      case ErrorResponse<VerifyPasswordResponce>():
        emit(
          state.copyWith(
            verifyOtpState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _handleResetPassword(ResetPassword intent) async {
    emit(state.copyWith(resetPasswordState: BaseState(isLoading: true)));

    final request = ResetPasswordRequest(
      newPassword: intent.newPassword,
      email: intent.email,
    );

    final response = await _resetPasswordUsecase.resetPassword(request);

    switch (response) {
      case SuccessResponse<ResetPasswordResponce>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;

      case ErrorResponse<ResetPasswordResponce>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
