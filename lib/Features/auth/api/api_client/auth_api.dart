import 'package:dio/dio.dart';

import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/forget_password/request/Forget_Password_Request.dart';
import '../../data/models/forget_password/request/Reset_Password_Request.dart';
import '../../data/models/forget_password/request/Verify_Password_Request.dart';
import '../../data/models/forget_password/responce/Forget_Password_Responce.dart';
import '../../data/models/forget_password/responce/Reset_Password_Responce.dart';
import '../../data/models/forget_password/responce/Verify_Password_Responce.dart';

part 'auth_api.g.dart';

@lazySingleton
@RestApi()
@injectable
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) = _AuthApi;
@POST(ApiConstants.forgetPassword)
  Future<ForgetPasswordResponce>forgetPassword(
    @Body()ForgetPasswordRequest forgetRequest
    );
@POST(ApiConstants.verifyResetCode)
  Future<VerifyPasswordResponce>verifyPassword(
    @Body()VerifyPasswordRequest verifyRequest
    );
@PUT(ApiConstants.resetPassword)
  Future<ResetPasswordResponce>resetPassword(
    @Body()ResetPasswordRequest resetRequest
    );

}
