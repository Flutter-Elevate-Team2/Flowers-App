import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple implements AuthRemoteDataSourceContract {
  AuthApi authApi;
  AuthRemoteDataSourceImple(this.authApi);
  @override
  Future<BaseResponse<ForgetPasswordResponce>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    try {
      final responce = await authApi.forgetPassword(request);
      if (responce.message == "success") {
        return SuccessResponse(data: responce);
      } else {
        return ErrorResponse(
          errorMessage: "There is no account with this email address",
        );
      }
    } catch (error) {
      return ErrorResponse(errorMessage: error.toString());
    }
  }

  @override
  Future<BaseResponse<ResetPasswordResponce>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final responce = await authApi.resetPassword(request);
      if (responce.message == "success") {
        return SuccessResponse(data: responce);
      } else {
        return ErrorResponse(errorMessage: "reset code not verified");
      }
    } catch (error) {
      return ErrorResponse(errorMessage: error.toString());
    }
  }

  @override
  Future<BaseResponse<VerifyPasswordResponce>> verifyPassword(
    VerifyPasswordRequest request,
  ) async {
    try {
      final responce = await authApi.verifyPassword(request);
      if (responce.status == "Success") {
        return SuccessResponse(data: responce);
      } else {
        return ErrorResponse(
          errorMessage: 'Reset code is invalid or has expired',
        );
      }
    } catch (error) {
      return ErrorResponse(errorMessage: error.toString());
    }
  }
}
