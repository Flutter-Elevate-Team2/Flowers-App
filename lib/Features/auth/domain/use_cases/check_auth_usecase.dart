import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckAuthUseCase {
  final AuthRepoContract _authRepo;

  CheckAuthUseCase(this._authRepo);

  Future<bool> call() async {
    return await _authRepo.isLoggedIn();
  }
}
