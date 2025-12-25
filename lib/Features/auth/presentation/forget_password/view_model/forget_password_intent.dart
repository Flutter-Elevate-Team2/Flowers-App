sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();
}
class SendOtp extends ForgetPasswordIntent{
   const SendOtp();

}
class verifyOtp extends ForgetPasswordIntent{
  const verifyOtp();
}
class resetpassword extends ForgetPasswordIntent{
  const resetpassword();
}