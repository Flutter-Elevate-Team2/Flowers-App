import 'package:dio/dio.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

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
