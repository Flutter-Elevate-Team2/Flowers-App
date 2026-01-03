import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../auth_repo_contract/auth_repo_contract.dart';
import '../entities/signup_entity.dart';

@injectable
class SignupUseCase {
  final AuthRepoContract _authRepo;

  SignupUseCase(this._authRepo);

  Future<BaseResponse<SignupEntity>> call(SignupRequest request) async {
    return await _authRepo.signUp(request);
  }
}
