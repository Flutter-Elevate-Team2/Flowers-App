import 'package:dio/dio.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flowers_app/core/constants/api_constants.dart';


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

  // === Signup Endpoint ===
  @POST(ApiConstants.signUp)
  Future<SignupResponse> signUp(@Body() SignupRequest request);
  // === Login Endpoint ===
  @POST(ApiConstants.signIn)
  Future<LoginResponse> login(@Body() LoginRequest request);
}
