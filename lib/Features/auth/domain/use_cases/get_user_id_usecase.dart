import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserIdUseCase {
  final AuthRepoContract _authRepoContract;

  GetUserIdUseCase(this._authRepoContract);

  Future<String?> call() async {
    return await _authRepoContract.getUserId();
  }
}
