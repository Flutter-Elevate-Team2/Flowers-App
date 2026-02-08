import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepoContract _profileRepo;

  ChangePasswordUseCase(this._profileRepo);

  Future<BaseResponse<ChangePasswordEntity>> call(
    String oldPassword,
    String newPassword,
  ) async {
    return await _profileRepo.changePassword(oldPassword, newPassword);
  }
}
