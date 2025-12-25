import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple
    with ApiExecutionMixin
    implements AuthRemoteDataSourceContract {
  final AuthApi _authApi;

  AuthRemoteDataSourceImple(this._authApi);

  @override
  Future<BaseResponse<ForgetPasswordResponce>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    return execute<ForgetPasswordResponce, ForgetPasswordResponce>(
      action: () async => await _authApi.forgetPassword(request),
      mapper: (response) {
        if (response.message == "success") {
          return response;
        } else {
          throw Exception("There is no account with this email address");
        }
      },
    );
  }

  @override
  Future<BaseResponse<ResetPasswordResponce>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    return execute<ResetPasswordResponce, ResetPasswordResponce>(
      action: () async => await _authApi.resetPassword(request),
      mapper: (response) {
        if (response.message == "success") {
          return response;
        } else {
          throw Exception("reset code not verified");
        }
      },
    );
  }

  @override
  Future<BaseResponse<VerifyPasswordResponce>> verifyPassword(
    VerifyPasswordRequest request,
  ) async {
    return execute<VerifyPasswordResponce, VerifyPasswordResponce>(
      action: () async => await _authApi.verifyPassword(request),
      mapper: (response) {
        if (response.status == "Success") {
          return response;
        } else {
          throw Exception('Reset code is invalid or has expired');
        }
      },
    );
  }
}
