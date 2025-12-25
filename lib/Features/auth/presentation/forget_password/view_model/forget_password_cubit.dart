import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordUsecase _forgetPasswordUsecase;
  final VerifyPasswordUsecase _verifyPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  late final TextEditingController emailController;

  ForgetPasswordCubit(super.initialState, this._forgetPasswordUsecase,
      this._verifyPasswordUsecase, this._resetPasswordUsecase);

  Future<void> doIntent(ForgetPasswordIntent intent) async {
    switch (intent) {
      case SendOtp():
        //_handleSendOtp(intent);
      case verifyOtp():
       // _handleVerifyOtp(intent);
      case resetpassword():
       // _handleResetPassword(intent);
    }
  }
}