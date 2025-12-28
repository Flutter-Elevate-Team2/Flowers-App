import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/forget_password/request/forget_password_request.dart';
import '../../data/models/forget_password/request/reset_password_request.dart';
import '../../data/models/forget_password/request/verify_password_request.dart';
import '../../data/models/forget_password/responce/forget_password_response.dart';
import '../../data/models/forget_password/responce/reset_password_response.dart';
import '../../data/models/forget_password/responce/verify_password_response.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple implements AuthRemoteDataSourceContract {
  final AuthApi _authApi;
  AuthRemoteDataSourceImple(this._authApi);
  @override
  Future<ForgetPasswordResponse> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    return await _authApi.forgetPassword(request);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
    ResetPasswordRequest request,
  ) async {
    return await _authApi.resetPassword(request);
  }

  @override
  Future<VerifyPasswordResponse> verifyPassword(
    VerifyPasswordRequest request,
  ) async {
    return await _authApi.verifyPassword(request);
  }
}
