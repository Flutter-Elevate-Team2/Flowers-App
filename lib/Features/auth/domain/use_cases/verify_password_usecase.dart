import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyPasswordUsecase {
  final AuthRepoContract _authRepoContract;

  VerifyPasswordUsecase(this._authRepoContract);
  Future<BaseResponse<VerifyPasswordEntity>> verifyPassword(
    VerifyPasswordRequest request,
  ) async {
    return await _authRepoContract.verifyPassword(request);
  }
}
