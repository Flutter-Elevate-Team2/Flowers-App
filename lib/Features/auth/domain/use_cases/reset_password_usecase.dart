import 'package:flowers_app/Features/auth/data/models/forget_password/request/Reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../auth_repo_contract/auth_repo_contract.dart';

@injectable
class ResetPasswordUsecase {
  final AuthRepoContract _authRepoContract;
  ResetPasswordUsecase(this._authRepoContract);
  Future<BaseResponse<ResetPasswordResponce>>resetPassword(ResetPasswordRequest request)async{
    return await _authRepoContract.resetPassword(request);
  }

}