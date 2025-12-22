import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

import '../entities/signup_entity.dart';

abstract class AuthRepoContract {
  Future<BaseResponse<SignupEntity>> signUp(SignupRequest requestModel);
}
