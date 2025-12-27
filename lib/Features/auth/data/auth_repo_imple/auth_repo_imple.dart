import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../auth_data_source_contract/auth_remote_data_source_contract.dart';
import '../models/forget_password/request/Forget_Password_Request.dart';
import '../models/forget_password/request/Reset_Password_Request.dart';
import '../models/forget_password/request/Verify_Password_Request.dart';
import '../models/forget_password/responce/Forget_Password_Responce.dart';
import '../models/forget_password/responce/Reset_Password_Responce.dart';
import '../models/forget_password/responce/Verify_Password_Responce.dart';
@Injectable(as:AuthRepoContract)
class AuthRepoImple implements AuthRepoContract {
   final AuthRemoteDataSourceContract _authRemoteDataSourceContract;
  AuthRepoImple(this._authRemoteDataSourceContract);
  @override
  Future<BaseResponse<ForgetPasswordResponce>> forgetPassword(ForgetPasswordRequest request) async{
    return await _authRemoteDataSourceContract.forgetPassword(request);

  }

  @override
  Future<BaseResponse<ResetPasswordResponce>> resetPassword(ResetPasswordRequest request)async {
    return await _authRemoteDataSourceContract.resetPassword(request);

  }

  @override
  Future<BaseResponse<VerifyPasswordResponce>> verifyPassword(VerifyPasswordRequest request)async{
    return await _authRemoteDataSourceContract.verifyPassword(request);

  }
}
