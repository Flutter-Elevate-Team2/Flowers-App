import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LogoutUseCase {
  final ProfileRepoContract _profileRepo;
  final SharedPreferences _prefs;
  final SessionController _sessionController;

  LogoutUseCase(
    this._profileRepo,
    this._prefs,
    this._sessionController,
  );

  Future<BaseResponse<String>> call() async {
    final result = await _profileRepo.logout();

    if (result is SuccessResponse) {
      await _prefs.remove('token');
      _sessionController.expireSession();
    }

    return result;
  }
}
