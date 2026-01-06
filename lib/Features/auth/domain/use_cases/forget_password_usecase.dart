import 'package:flowers_app/Features/auth/data/models/forget_password/request/forget_password_request/forget_password_request.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUsecase {
  final AuthRepoContract _authRepoContract;

  ForgetPasswordUsecase(this._authRepoContract);

  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    return await _authRepoContract.forgetPassword(request);
  }
}
