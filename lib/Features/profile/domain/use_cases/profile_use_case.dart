import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base_response/base_response.dart';
import '../entities/user_entity.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepoContract _profileRepo;

  GetProfileUseCase(this._profileRepo);

  Future<BaseResponse<UserEntity>> call() async {
    return await _profileRepo.getProfileData();
  }
}
