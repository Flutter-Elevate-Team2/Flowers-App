import 'package:dio/dio.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/forget_password/request/forget_password_request.dart';
import '../../data/models/forget_password/request/reset_password_request.dart';
import '../../data/models/forget_password/request/verify_password_request.dart';
import '../../data/models/forget_password/responce/forget_password_response.dart';
import '../../data/models/forget_password/responce/reset_password_response.dart';
import '../../data/models/forget_password/responce/verify_password_response.dart';

part 'auth_api.g.dart';

@lazySingleton
@RestApi()
@injectable
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) = _AuthApi;
  @POST(ApiConstants.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest forgetRequest,
  );
  @POST(ApiConstants.verifyResetCode)
  Future<VerifyPasswordResponse> verifyPassword(
    @Body() VerifyPasswordRequest verifyRequest,
  );
  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest resetRequest,
  );
}
