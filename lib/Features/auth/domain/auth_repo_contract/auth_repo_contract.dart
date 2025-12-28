import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class AuthRepoContract {
   Future<BaseResponse<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequest request,
  );
  Future<BaseResponse<VerifyPasswordEntity>> verifyPassword(
    VerifyPasswordRequest request,
  );
  Future<BaseResponse<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequest request,
  );
}
