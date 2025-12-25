sealed class ForgetPasswordIntent {}

class SendOtp extends ForgetPasswordIntent {
  final String email;
  SendOtp({required this.email});
}

class VerifyOtp extends ForgetPasswordIntent {
  final String otp;
  VerifyOtp({required this.otp});
}

class ResetPassword extends ForgetPasswordIntent {
  final String newPassword;
  final String email;
  ResetPassword({required this.newPassword, required this.email});
}
