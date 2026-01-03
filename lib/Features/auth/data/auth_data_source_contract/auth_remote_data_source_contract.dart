import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/verify_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<SignupResponse> signUp(SignupRequest request);
  Future<LoginResponse> login(LoginRequest request);
  Future<ForgetPasswordResponce> forgetPassword(ForgetPasswordRequest request);
  Future<VerifyPasswordResponce> verifyPassword(VerifyPasswordRequest request);
  Future<ResetPasswordResponce> resetPassword(ResetPasswordRequest request);
}
