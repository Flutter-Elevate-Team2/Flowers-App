import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base_response/base_response.dart';
import '../entities/user_entity.dart';
import '../repo/profile_repo_contract.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepoContract _profileRepo;

  EditProfileUseCase(this._profileRepo);

  Future<BaseResponse<UserEntity>> call(EditProfileRequest request) async {
    return await _profileRepo.editProfile(request);
  }
}
