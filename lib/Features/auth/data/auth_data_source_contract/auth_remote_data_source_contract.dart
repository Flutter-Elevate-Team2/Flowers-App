import 'package:flowers_app/Features/auth/data/models/login_models/login_request.dart';
import 'package:flowers_app/Features/auth/data/models/login_models/login_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<LoginResponse> login(LoginRequest request);
}
