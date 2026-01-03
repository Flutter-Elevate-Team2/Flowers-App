sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();
}
class SendOtp extends ForgetPasswordIntent{
  final String email;
   const SendOtp({required this.email});
}
class VerifyOtp extends ForgetPasswordIntent{
  final String otp;
  const VerifyOtp({required this.otp});
}
class Resetpassword extends ForgetPasswordIntent{
  final String newPassword;
  final String email;
  const Resetpassword({required this.email,required this.newPassword});
}
