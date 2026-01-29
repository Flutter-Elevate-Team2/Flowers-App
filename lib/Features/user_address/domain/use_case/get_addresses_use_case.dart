import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressesUseCase {
  final UserAddressRepoContract _repo;

  GetAddressesUseCase(this._repo);

  Future<BaseResponse<AddressResponseEntity>> call() async {
    return await _repo.getAddresses();
  }
}
