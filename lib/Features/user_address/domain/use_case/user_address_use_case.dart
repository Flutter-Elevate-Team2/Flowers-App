import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
@injectable
class UserAddressUseCase {
  final UserAddressRepoContract _repo;
  UserAddressUseCase(this._repo);
  Future<BaseResponse<AddressResponseEntity>> editAddress(
    EditAddressRequest editAddressRequest,
    String id
  ) {
    return _repo.editAddress(editAddressRequest, id);
  }
  Future<BaseResponse<AddressResponseEntity>> deleteAddress(String id) {
    return _repo.deleteAddress(id);
  }
}
