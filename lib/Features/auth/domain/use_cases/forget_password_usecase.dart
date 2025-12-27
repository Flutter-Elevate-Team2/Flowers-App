import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/forget_password/request/Forget_Password_Request.dart';
import '../../data/models/forget_password/responce/Forget_Password_Responce.dart';

@injectable
class ForgetPasswordUsecase {
  final AuthRepoContract _authRepoContract;

  ForgetPasswordUsecase(this._authRepoContract);
  Future<BaseResponse<ForgetPasswordResponce>>forgetPassword(ForgetPasswordRequest request)async{
    return await _authRepoContract.forgetPassword(request);
  }

}