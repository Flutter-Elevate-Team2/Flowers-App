import '../models/forget_password/request/forget_password_request.dart';
import '../models/forget_password/request/reset_password_request.dart';
import '../models/forget_password/request/verify_password_request.dart';
import '../models/forget_password/responce/forget_password_response.dart';
import '../models/forget_password/responce/reset_password_response.dart';
import '../models/forget_password/responce/verify_password_response.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest request);
  Future<VerifyPasswordResponse> verifyPassword(VerifyPasswordRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
}
