import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/repos/commerce_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeSectionsUseCase {
  final CommerceRepoContract _repo;

  GetHomeSectionsUseCase(this._repo);

  Future<BaseResponse<HomeEntity>> call() async {
    return await _repo.getHomeSections();
  }
}
