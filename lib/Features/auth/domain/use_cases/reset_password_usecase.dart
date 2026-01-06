import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUsecase {
  final AuthRepoContract _authRepoContract;
  ResetPasswordUsecase(this._authRepoContract);

  Future<BaseResponse<ResetPasswordEntity>> resetPassword(ResetPasswordRequest request) async {
    return await _authRepoContract.resetPassword(request);
  }
}
