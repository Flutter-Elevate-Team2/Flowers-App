import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepoContract _authRepo;

  LoginUseCase(this._authRepo);

  Future<BaseResponse<LoginEntity>> call({
    required String email,
    required String password,
    required bool isRememberMe,
  }) {
    return _authRepo.login(email, password, isRememberMe);
  }
}
