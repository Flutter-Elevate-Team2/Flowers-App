
import 'package:flowers_app/core/base_response/base_response.dart';

import '../../data/models/forget_password/request/Forget_Password_Request.dart';
import '../../data/models/forget_password/request/Reset_Password_Request.dart';
import '../../data/models/forget_password/request/Verify_Password_Request.dart';
import '../../data/models/forget_password/responce/Forget_Password_Responce.dart';
import '../../data/models/forget_password/responce/Reset_Password_Responce.dart';
import '../../data/models/forget_password/responce/Verify_Password_Responce.dart';

abstract class AuthRepoContract {
  Future<BaseResponse<ForgetPasswordResponce>>forgetPassword(ForgetPasswordRequest request);
  Future<BaseResponse<VerifyPasswordResponce>>verifyPassword(VerifyPasswordRequest request);
  Future<BaseResponse<ResetPasswordResponce>>resetPassword(ResetPasswordRequest request);
}
