import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUsecase _forgetPasswordUsecase;
  final VerifyPasswordUsecase _verifyPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;

  ForgetPasswordCubit(super.initialState, this._forgetPasswordUsecase,
      this._verifyPasswordUsecase, this._resetPasswordUsecase);

  Future<void> doIntent(ForgetPasswordIntent intent) async {
    switch (intent) {
      case SendOtp():
        //_handleSendOtp(intent);
        break;
      case VerifyOtp():
       // _handleVerifyOtp(intent);
        break;
      case Resetpassword():
       // _handleResetPassword(intent);
        break;
    }
  }
}
