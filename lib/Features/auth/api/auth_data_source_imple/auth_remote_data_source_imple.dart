import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
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
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple implements AuthRemoteDataSourceContract {
  final AuthApi _authApi;

  AuthRemoteDataSourceImple(this._authApi);

  @override
  Future<SignupResponse> signUp(SignupRequest request) async {
    return await _authApi.signUp(request);
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    return await _authApi.login(request);
  }

  @override
  Future<ForgetPasswordResponce> forgetPassword(ForgetPasswordRequest request) async {
    return await _authApi.forgetPassword(request);
  }

  @override
  Future<ResetPasswordResponce> resetPassword(ResetPasswordRequest request) async {
    return await _authApi.resetPassword(request);
  }

  @override
  Future<VerifyPasswordResponce> verifyPassword(VerifyPasswordRequest request) async {
    return await _authApi.verifyPassword(request);
  }
}
