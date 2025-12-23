import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class AuthRepoContract {
  Future<BaseResponse<LoginEntity>> login(String email, String password);
}
