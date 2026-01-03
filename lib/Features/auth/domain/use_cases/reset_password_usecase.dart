import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/forget_password/request/reset_password_request.dart';
import '../auth_repo_contract/auth_repo_contract.dart';
@injectable
class ResetPasswordUsecase {
  final AuthRepoContract _authRepoContract;
  ResetPasswordUsecase(this._authRepoContract);

  Future<BaseResponse<ResetPasswordEntity>> resetPassword(ResetPasswordRequest request) async {
    return await _authRepoContract.resetPassword(request);
  }
}
