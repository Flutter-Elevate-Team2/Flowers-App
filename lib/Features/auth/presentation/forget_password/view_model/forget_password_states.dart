import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

import '../../../data/models/forget_password/responce/Reset_password_responce.dart';

class ForgetPasswordStates {

}
class SendOtpState extends ForgetPasswordStates{
  final BaseState<ForgetPasswordResponce>?forgetPassword;
  SendOtpState({this.forgetPassword});
  SendOtpState copywith(BaseState<ForgetPasswordResponce>newstate){
    return SendOtpState(forgetPassword: newstate);
  }
}
class VerifyOtp extends ForgetPasswordStates{
  final BaseState<VerifyPasswordResponce>?verifypassword;
  VerifyOtp({this.verifypassword});
  VerifyOtp copywith(BaseState<VerifyPasswordResponce>newstate){
    return VerifyOtp(verifypassword:newstate);
  }

}
class ResetPassword extends ForgetPasswordStates{
  final BaseState<ResetPasswordResponce>?resetpassword;
  ResetPassword({this.resetpassword});
  ResetPassword copywith(BaseState<ResetPasswordResponce>newstate){
    return ResetPassword(resetpassword:newstate);
  }

}