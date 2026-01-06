
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepoContract _profileRepo;

  ChangePasswordUseCase(this._profileRepo);

  Future<BaseResponse<ChangePasswordEntity>> call(String oldPassword, String newPassword) async {
    final request = ChangePasswordRequest(
      password: oldPassword,
      newPassword: newPassword,
    );
    return await _profileRepo.changePassword(request);
  }
}
