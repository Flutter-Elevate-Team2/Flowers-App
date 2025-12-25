import 'package:flowers_app/Features/auth/data/models/forget_password/request/Forget_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/Verify_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../auth_data_source_contract/auth_remote_data_source_contract.dart';
@Injectable(as:AuthRepoContract)
class AuthRepoImple implements AuthRepoContract {
  AuthRemoteDataSourceContract authRemoteDataSourceContract;
  AuthRepoImple(this.authRemoteDataSourceContract);
  @override
  Future<BaseResponse<ForgetPasswordResponce>> forgetPassword(ForgetPasswordRequest request) async{
    return await authRemoteDataSourceContract.forgetPassword(request);

  }

  @override
  Future<BaseResponse<ResetPasswordResponce>> resetPassword(ResetPasswordRequest request)async {
    return await authRemoteDataSourceContract.resetPassword(request);

  }

  @override
  Future<BaseResponse<VerifyPasswordResponce>> verifyPassword(VerifyPasswordRequest request)async{
    return await authRemoteDataSourceContract.verifyPassword(request);

  }
}
