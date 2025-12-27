import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/forget_password/request/Reset_Password_Request.dart';
import '../../data/models/forget_password/responce/Reset_Password_Responce.dart';
import '../auth_repo_contract/auth_repo_contract.dart';

@injectable
class ResetPasswordUsecase {
  final AuthRepoContract _authRepoContract;
  ResetPasswordUsecase(this._authRepoContract);
  Future<BaseResponse<ResetPasswordResponce>>resetPassword(ResetPasswordRequest request)async{
    return await _authRepoContract.resetPassword(request);
  }

}