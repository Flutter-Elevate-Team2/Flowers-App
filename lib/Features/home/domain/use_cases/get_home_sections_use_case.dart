import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/domain/repo/home_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeSectionsUseCase {
  final HomeRepoContract _homeRepoContract;

  GetHomeSectionsUseCase(this._homeRepoContract);

  Future<BaseResponse<HomeEntity>> call() async {
    return await _homeRepoContract.getHomeSections();
  }
}
