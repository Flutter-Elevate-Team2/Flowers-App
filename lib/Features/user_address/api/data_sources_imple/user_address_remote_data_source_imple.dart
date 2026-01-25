import 'package:flowers_app/Features/user_address/api/api_client/user_address_api.dart';
import 'package:flowers_app/Features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flowers_app/Features/user_address/data/models/delete_address_response/delete_address_response.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_response/edit_address_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: UserAddressRemoteDataSourceContract)
class UserAddressRemoteDataSourceImple
    implements UserAddressRemoteDataSourceContract {
  final UserAddressApi _userAddressApi;
  UserAddressRemoteDataSourceImple(this._userAddressApi);
  @override
  Future<DeleteAddressResponse> deleteAddress(String id) async {
    return await _userAddressApi.deleteAddress(id);
  }

  @override
  Future<EditAddressResponse> editAddress(
    EditAddressRequest editAddressRequest,String id
  ) async {
    return await _userAddressApi.editAddress(id,editAddressRequest);
  }
}
