import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/forget_password/request/Verify_Password_Request.dart';
import '../../data/models/forget_password/responce/Verify_Password_Responce.dart';

@injectable
class VerifyPasswordUsecase {
  final AuthRepoContract _authRepoContract;

  VerifyPasswordUsecase(this._authRepoContract);
  Future<BaseResponse<VerifyPasswordResponce>>verifyPassword(VerifyPasswordRequest request)async{
    return await _authRepoContract.verifyPassword(request);
  }

}