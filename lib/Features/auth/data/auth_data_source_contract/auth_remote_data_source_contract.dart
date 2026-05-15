import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/forget_password_response/forget_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/reset_password_response/reset_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/response/verify_password_response/verify_password_response.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<SignupResponse> signUp(SignupRequest request);
  Future<LoginResponse> login(LoginRequest request);
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest request);
  Future<VerifyPasswordResponse> verifyPassword(VerifyPasswordRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
}
