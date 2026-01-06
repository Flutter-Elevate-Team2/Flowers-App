import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUsecase _forgetPasswordUsecase;
  final VerifyPasswordUsecase _verifyPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;

  ForgetPasswordCubit(
    this._forgetPasswordUsecase,
    this._verifyPasswordUsecase,
    this._resetPasswordUsecase,
  ) : super(ForgetPasswordState());

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
    emit(
      state.copyWith(
        sendOtpState: BaseState<ForgetPasswordEntity>(isLoading: true),
      ),
    );

    final request = ForgetPasswordRequest(email: intent.email);

    final response = await _forgetPasswordUsecase.forgetPassword(request);

    switch (response) {
      case SuccessResponse<ForgetPasswordEntity>():
        emit(
          state.copyWith(
            sendOtpState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;

      case ErrorResponse<ForgetPasswordEntity>():
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
    emit(
      state.copyWith(
        verifyOtpState: BaseState<VerifyPasswordEntity>(isLoading: true),
      ),
    );

    final request = VerifyPasswordRequest(resetCode: intent.otp);

    final response = await _verifyPasswordUsecase.verifyPassword(request);

    switch (response) {
      case SuccessResponse<VerifyPasswordEntity>():
        emit(
          state.copyWith(
            verifyOtpState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;

      case ErrorResponse<VerifyPasswordEntity>():
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
    emit(
      state.copyWith(
        resetPasswordState: BaseState<ResetPasswordEntity>(isLoading: true),
      ),
    );

    final request = ResetPasswordRequest(
      newPassword: intent.newPassword,
      email: intent.email,
    );

    final response = await _resetPasswordUsecase.resetPassword(request);

    switch (response) {
      case SuccessResponse<ResetPasswordEntity>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;

      case ErrorResponse<ResetPasswordEntity>():
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
