import 'package:flowers_app/Features/user_address/api/api_client/user_address_api.dart';
import 'package:flowers_app/Features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserAddressRemoteDataSourceContract)
class UserAddressRemoteDataSourceImple implements UserAddressRemoteDataSourceContract {
  final UserAddressApi _api;

  UserAddressRemoteDataSourceImple(this._api);

  @override
  Future<AddressResponseModel> addAddress(AddAddressRequest request) {
    return _api.addAddress(request);
  }
  @override
  Future<AddressResponseModel> getAddresses() {
    return _api.getAddresses();
  }
}
