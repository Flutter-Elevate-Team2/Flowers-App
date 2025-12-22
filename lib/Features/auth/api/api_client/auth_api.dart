import 'package:dio/dio.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flowers_app/core/constants/api_constants.dart';


part 'auth_api.g.dart';

@lazySingleton
@RestApi()
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) = _AuthApi;

  // === Signup Endpoint ===
  @POST(ApiConstants.signUp)
  Future<SignupResponse> signUp(@Body() SignupRequest request);
}
