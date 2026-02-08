import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final ProfileRepoContract _profileRepo;

  LogoutUseCase(this._profileRepo);

  Future<BaseResponse<String>> call() async {
    return await _profileRepo.logout();
  }
}
