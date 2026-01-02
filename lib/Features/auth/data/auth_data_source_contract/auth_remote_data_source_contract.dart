import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<SignupResponse> signUp(SignupRequest request);
}

