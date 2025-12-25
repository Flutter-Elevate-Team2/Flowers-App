import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

import '../models/forget_password/request/Reset_password_request.dart';
import '../models/forget_password/request/Verify_password_request.dart';
import '../models/forget_password/responce/Reset_password_responce.dart';
import '../models/forget_password/responce/Verify_password_responce.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<BaseResponse<ForgetPasswordResponce>>forgetPassword(ForgetPasswordRequest request);
  Future<BaseResponse<VerifyPasswordResponce>>verifyPassword(VerifyPasswordRequest request);
  Future<BaseResponse<ResetPasswordResponce>>resetPassword(ResetPasswordRequest request);


}
